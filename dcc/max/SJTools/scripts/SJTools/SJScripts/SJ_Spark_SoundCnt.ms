/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_SoundCnt.ms
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "�ȈՃv���T�E���h�Ǘ�"
	(
	button soundCntAllDelBt "�S�T�E���h���폜" width:160  hight:20
	button soundCntSaveBt "�T�E���h�ݒ��ۑ�" width:160  hight:20
	button soundCntLoadBt "�T�E���h�ݒ���J��" width:160  hight:20
	)
	
	on soundCntAllDelBt pressed do
	(
		--�ϐ�
		local sndCount = 0;
		
		--�A�N�e�B�u��?
		if (prosound.isActive()) then
			(
				sndCount = prosound.NumTracks();
				--�T�E���h�g���b�N��S���폜
				for i = 1 to sndCount do
				(
					prosound.delete 1;
				);--for end
			);--if end
			
		--������
		ProSound.Init(true);
			
	
			
			
	);--on end

	
	on soundCntSaveBt pressed do
	(
		--�ϐ�
		local sndCount = 0;
		
		--�A�N�e�B�u��?
		if (prosound.isActive()) then
			(
				
				--for���[�v�񐔂�ݒ�
				sndCount = prosound.NumTracks();
				
		--�ۑ��͑S�ݒ�������o��
		local saveFile = getSaveFileName types:"Setting File (*.txt)|*.txt|All(*.*)|*.*" caption:"�T�E���h�ݒ��ۑ�";
		
				--�ۑ��t�@�C�����ݒ肳��Ă����
				if saveFile != undefined do
				(
					--�ۑ��t�@�C�����쐬
					saveFileList = createFile saveFile;
					
					--�g���b�N�̐��������o��
					format "%\n" sndCount to:saveFileList;
					
						--�T�E���h�g���b�N�ݒ�������o��
						for i = 1 to sndCount do
						(
							--�ォ�珇�Ƀt�@�C���A�G���h���ԁA�X�^�[�g����
							format "%\n" (prosound.name i) to:saveFileList;
							format "%\n" (prosound.end i) to:saveFileList;
							format "%\n" (prosound.start i) to:saveFileList;
						);--for end
					--�t�@�C�������
					close saveFileList
				)--if end

			);--if end
			
	);--on end
	
	
	
	on soundCntLoadBt pressed do
	(
		--�܂���U���������Ă�����s����
		ProSound.Init(true);
		
		--�ϐ�
		local sndCount = 0;
		
		--�A�N�e�B�u��?
		if (prosound.isActive()) then
			(
				--�Ō�̂��̂̓T�E���h�t�@�C�������邩�`�F�b�N����
				Local loadItemCount = 0, checkFile = true;
				Local loadFile = getOpenFileName types:"Setting File (*.txt)|*.txt|All(*.*)|*.*" caption:"�T�E���h�ݒ���J��";
				
				if loadFile != undefined do
				(
					--�t�@�C�����擾
					loadFileList = openFile loadFile;
					
					--�ŏ���1�s�ɓǂݍ��މ񐔂�������Ă���
					loadItemCount = readValue loadFileList;
					
					for i=1 to loadItemCount do
					(
						--���^�[���l�ł���]��������A���s�Ȃ�false
						checkFile = prosound.append (( readLine loadFileList ) as String);
						
						if checkFile then
						(
							--�ǉ������Ō��ID�̃t�@�C����ݒ肷��̂ŁA1���[�v�����ɍŌ��ID������
							sndCount = prosound.NumTracks();
							--�ݒ�̓G���h�^�C������
							prosound.Setend sndCount (readValue loadFileList);
							prosound.Setstart sndCount (readValue loadFileList);
							--prosound.shift sndCount (readValue loadFileList);
						)else(
							--2�s���̓ǂݍ��݌��ʂ͔j��
							sndCount = readValue loadFileList;
							sndCount = readValue loadFileList;
						);--if end
						
					)--for end
					close loadFileList
				)--if end
			);--if end
	);--on end