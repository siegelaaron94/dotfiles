#!/usr/bin/python
import os
import queue
import subprocess
import json
import sys

def collect_git_repo(projects, project_root):
    project_name = os.path.basename(project_root)

    project = {
        'name': project_name,
        'root': os.path.relpath(project_root, projects['projects']['root'])
    }

    if project_name in projects:
        project = projects[project_name]
    projects[project_name] = project

    try:
        project['origin'] = subprocess.check_output(['git', '-C', project_root, 'remote',
                                                     'get-url', '--push', 'origin'], stderr=subprocess.DEVNULL).decode('utf-8').strip()

    except subprocess.CalledProcessError:
        pass


def collect_projects(manage_directory):
    projects = {
        'projects': {
            'root': manage_directory
        }
    }

    projects_file_path = os.path.join(manage_directory, '.projects.json')

    if os.path.exists(projects_file_path):
        with open(projects_file_path, 'r') as projects_file:
            projects = json.load(projects_file)

    folders_to_walk = queue.Queue()
    folders_to_walk.put(projects['projects']['root'])

    while not folders_to_walk.empty():
        project_root = folders_to_walk.get()
        project_git = os.path.join(project_root, '.git')

        if os.path.exists(project_git):
            collect_git_repo(projects, project_root)
        else:
            try:
                for subpath in os.listdir(project_root):
                    full_path = os.path.join(project_root, subpath)
                    if os.path.isdir(full_path) and not os.path.islink(full_path):
                        folders_to_walk.put(full_path)
            except PermissionError:
                pass

    with open(projects_file_path, 'w') as project_file:
        project_file.write(json.dumps(projects, indent=4, sort_keys=False))
    return projects

MANAGE_ROOT = os.path.abspath(os.path.join(os.path.expanduser("~"), "projects"))
projects = collect_projects(MANAGE_ROOT)

if len(sys.argv) >= 3:
    command = sys.argv[1].lower()
    if command == 'pwd':
        print(os.path.join(projects['projects']['root'],
                           projects[sys.argv[2]]['root']))
