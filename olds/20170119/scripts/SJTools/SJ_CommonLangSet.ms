/*******************************************************
System J Tools 
********************************************************
Name:SJ_Language_Settig
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
-----------------------------------------------------------------------------------------------------------
--��{����t�@�C��
Local language = getINISetting ("$scripts/SJTools/SJTools.ini") "SJTools" "Language";

--�p�X�̐؂蕪��
if  (language == "JP") then
(
	--���{��
	Local languageFilePath = "$scripts/SJTools/SJTools_JP.ini";
)else(
	--���{��ȊO�͊�{�p��
	Local languageFilePath = "$scripts/SJTools/SJTools_EN.ini";
);

--�S�Ẵc�[���ŋ��ʂ̕�����

Local MesseTitleInfoStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseTitleInfoStr");
Local MesseTitleWngStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseTitleWngStr");
Local MesseTitleCtnStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseTitleCtnStr");
Local MesseTitleErrStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseTitleErrStr");
Local MesseTitleChkStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseTitleChkStr");

--ini�̉��s�R�[�h���g�������ꍇ��execute�������A�����ini��"���d�ɐݒu����
Local MesseCmnErrStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseCmnErrStr");
Local MesseCmnChkStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseCmnChkStr");
Local MesseCmnFileErrStr = execute(getINISetting(languageFilePath) "SJ_Tools_Common" "MesseCmnFileErrStr");
Local MesseCmnProgStr = (getINISetting(languageFilePath) "SJ_Tools_Common" "MesseCmnProgStr");