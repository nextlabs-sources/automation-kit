import re
#from robot.libraries.BuiltIn import BuiltIn

def read_conn_file(filepath):
    var_dict={}
    with open(filepath,'r') as conn:
        lines = conn.read()
    roots=re.findall(r'\nroots[\s\S]*?(?=\#)',lines)
    removed_roots=re.sub(r'\nroots[\s\S]*?(?=\#)','',lines)
    reduced_lines=re.sub(r"(#.*\n)","",removed_roots)
    for tup in re.findall(r"\n(\S*)[ |\t]*(.*)",reduced_lines):
        var_dict[tup[0].strip()]=tup[1].strip()
    if roots:
        var_dict['roots']=[x.strip() for x in roots[0].replace('\nroots','').replace('\n\n','').split('\\n\\\n')]
    return {k:v for k,v in var_dict.items() if v!=''}

def def_to_dict(filepath):
    var_dict={}
    with open(filepath,'r') as conn:
        lines = conn.read()
    reduced_lines=re.sub(r"(#.*\n)","",lines)
    for tup in re.findall(r"\n([\w|\.]*)[ |\t]*([\S| |\t]*)",reduced_lines):
        var_dict[tup[0].strip()]=tup[1].strip()
    return {k:v for k,v in var_dict.items() if v!=''}

def conn_to_sub(pattern,main_dict,sub_dict=None):
    del_dict=main_dict.copy()
    if sub_dict==None:
        sub_dict2={}
    else:
        sub_dict2=sub_dict.copy()
    for key in main_dict:
        if re.match(pattern,key)!=None:
            sub_dict2[key]=main_dict[key]
            del_dict.pop(key)
    return sub_dict2, del_dict

def read_def_file(filepath):
    to_enroll,def_dict2=conn_to_sub(r'enroll.[\w]*',def_to_dict(filepath))
    requirements,def_dict2=conn_to_sub(r'entry.attributefor\.[\w]*',def_dict2)
    requirements,def_dict2=conn_to_sub(r'store.missing.attributes',def_dict2,requirements)
    requirements,def_dict2=conn_to_sub(r'delete.inactive.group.members',def_dict2,requirements)
    if 'enroll.others' in to_enroll.keys():
        to_enroll['enroll.other entities']=to_enroll.pop('enroll.others')
        if 'other.requirements' in def_dict2.keys():
            requirements['other entitie.requirements']=def_dict2.pop('other.requirements')
    for key in list(to_enroll.keys()):
        if to_enroll[key]=='false':
            to_enroll.pop(key)
    mappings={}
    for key in to_enroll.keys():
        entity = key.split('.')[1]
        requirements,def_dict2=conn_to_sub(entity[:-1]+r'\.requirements',def_dict2,requirements)
        requirements,def_dict2=conn_to_sub(entity[:-1]+r'\.attributefor\.[\w]*',def_dict2,requirements)
        mappings[entity],def_dict2=conn_to_sub(entity[:-1]+r'\.[\w]*\.[\w]*',def_dict2)
    filename,def_dict2=conn_to_sub(r'ldif.filename',def_dict2)
    if 'groups' in mappings.keys():
        if 'structure.requirements' in def_dict2.keys():
            if def_dict2['structure.requirements']!='':
                requirements['structure.requirements']=def_dict2['structure.requirements']
    full_dict={'to_enroll':to_enroll,'requirements':requirements,'mappings':mappings,'filename':filename}
    return full_dict

"""
def checkbox_interaction(xpath,value):
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    wd = se2lib._current_browser()
    locator = "document.evaluate('{0}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue".format(xpath)
    check = ".checked = {0}".format(value)
    change = ".dispatchEvent(new Event('change'))"
    wd.execute_javascript(locator+check)
    wd.execute_javascript(locator+change)
    return
"""
