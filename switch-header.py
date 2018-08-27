#!/usr/bin/python
import os, sys
SOUCE_HEADER_MAP = {
    ".cpp": set([ ".hpp", ".h" ]),
    ".c": set([ ".h" ])
}

for key in SOUCE_HEADER_MAP.keys():
    for ext in SOUCE_HEADER_MAP[key]:
        if ext not in SOUCE_HEADER_MAP.keys():
            SOUCE_HEADER_MAP[ext] = set([])
        SOUCE_HEADER_MAP[ext].add(key)

def path_splitall(path):
    path = os.path.normpath(path)
    return path.split(os.sep)

def score_result(basepath, filename, other):
    relpath = path_splitall(os.path.relpath(other, basepath))

    basepath = path_splitall(basepath)
    other_basepath, other_filename = os.path.split(other)
    other_basepath = path_splitall(other_basepath)
    base_score = len(set(basepath).intersection(other_basepath))
    return 10 * base_score - len(relpath)


def detect_header_source_convention(source_file, project_root='.'):
    project_root = os.path.abspath(project_root)
    source_file = os.path.abspath(source_file)
    basepath, filename = os.path.split(source_file)
    name, ext = os.path.splitext(filename)

    potential_others = {}
    for sibling_filename in os.listdir(basepath):
        sibling_name, sibling_ext = os.path.splitext(sibling_filename)
        if sibling_ext == ext:
            sibling_path = os.path.join(basepath, sibling_filename)
            sibling_other = switch_header_source(sibling_path, project_root, False)
            if sibling_other:
                other = sibling_other.replace(sibling_name, name)
                if other not in potential_others:
                    potential_others[other] = 0
                potential_others[other] += 1
    potential_others = [ (other, potential_others[other]) for other in potential_others ]
    potential_others.sort(key=lambda x: x[1], reverse=True)
    return potential_others[0][0]


def switch_header_source(source_file, project_root=".", generate_new=False):
    project_root = os.path.abspath(project_root)
    source_file = os.path.abspath(source_file)
    basepath, filename = os.path.split(source_file)

    name, ext = os.path.splitext(filename)
    other_filenames = [name + other_ext for other_ext in SOUCE_HEADER_MAP[ext]]

    potential_others = []
    for root, dirs, files in os.walk(project_root):
        for file in files:
            if file in other_filenames:
                potential_others.append(os.path.join(root, file))
        if '.git' in dirs:
            dirs.remove('.git')


    potential_others = [(other, score_result(basepath, filename, other)) for other in potential_others]

    potential_others.sort(key=lambda x: x[1], reverse=True)

    if not potential_others:
        if generate_new:
            return detect_header_source_convention(source_file, project_root)
        else:
            return None

    return potential_others[0][0]


print(switch_header_source(sys.argv[1], ".", True))


