filein @"D:\sakai\SJTools\dcc\max\SJTools\scripts\SJTools\SJCollectTextures\SJCollectTextures.ms"
/*
speFld = dotNetClass "System.Environment+specialFolder"
sysEnv = dotNetClass "System.Environment"
ret = sysEnv.getfolderPath speFld.MyDocuments;
showproperties speFld
*/
--ret = python.ExecuteFile @"D:\sakai\SJTools\dcc\max\SJTools\scripts\SJTools\SJCollectTextures\test_py.py";

-- �]���̕��@ $xxxx �Ńp�X���擾�ł���
-- https://help.autodesk.com/view/3DSMAX/2017/JPN/?guid=__files_GUID_0EE531B2_6FF8_4D0B_ACA1_5400E0B9D604_htm
-- print(symbolicPaths.getPathValue "$max");

-- Python�ō��̃t�@�C���̃p�X�Ƃ��}�C�h�L�������g�̃p�X��
-- python.Execute("print(os.path.abspath(sys.argv[0]))")
-- py = "print(os.environ.get(\"USERPROFILE\") + \"\\Documents\")";
-- python.Execute(py)

-- .Net���g����windows�̃X�y�V�����t�H���_���擾����
-- speFld = dotNetClass "System.Environment + specialFolder"
-- sysEnv = dotNetClass "System.Environment"
--ret = sysEnv.getfolderPath speFo.commonApplicationData;  -- ��������ƃv���O�����t�@�C���̃p�X������
-- ret = sysEnv.getfolderPath speFo.MyDocuments;
-- print(ret)

-- ret = HiddenDOSCommand "dir /b"
--ret = DOSCommand "dir /b"
-- print(ret)
-- ret = ShellLaunch @"D:\test.bat" "";
-- print(ret)
--print(sysEnv.getfolderPath speFld.commonApplicationData)
--print(sysEnv.getfolderPath speFld.MyDocuments)

/*
sys = python.Import("sys");
print(sys.argv[0])
*/

/*
local schk = python.Import("scene_checker");
        local result = #();
        local ret;
        for obj in chkObj do(
            ret = schk.checker.check_2byte_chara(obj.name);
*/