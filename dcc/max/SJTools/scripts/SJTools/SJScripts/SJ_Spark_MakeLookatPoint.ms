/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_MakeLookatPoint
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.CaptainHansode
*******************************************************/
		group "Make Lookat Point"
		(
			button mLookatPBt "���C�N���b�N�A�b�g�|�C���g" width:160
		label mLookatLbl1 "���b�N�A�b�g��" align:#left
		radiobuttons mLookatAxisRb "" width:160 enabled:true labels:#("X", "Y","Z") default:3 columns:3 align:#center
		label mLookatLbl2 "��{��" align:#left
		radiobuttons mLookatUpnodeRb "" width:160 enabled:true labels:#("X", "Y","Z") default:2 columns:3 align:#center
		)

-----------------------------------------------------------------------------------------------------------
-- �ȉ�����
-----------------------------------------------------------------------------------------------------------
--////////////
--�I�����b�V���̑I�𒸓_��Null��z�u����
--///////////
/*
$.rotation.controller = LookAt_Constraint ()
$.rotation.controller.appendTarget

$.rotation.controller.target_axis = 2
$.rotation.controller.upnode_axis = 1
$.rotation.controller.StoUP_axis = 1
on mLookatAxisRb changed state do
(
	myState = state;
	case mLookatUpnodeRb.state of
	(
	1:(if mLookatUpnodeRb.state == myState do mLookatUpnodeRb.state = 2);
	2:(if mLookatUpnodeRb.state == myState do mLookatUpnodeRb.state = 1);
	3:(if mLookatUpnodeRb.state == myState do mLookatUpnodeRb.state = 2);
	)

);--end
on mLookatUpnodeRb changed state do
(
	myState = state;
	case mLookatAxisRb.state of
	(
	1:(if mLookatAxisRb.state == myState do mLookatUpnodeRb.state = 2);
	2:(if mLookatAxisRb.state == myState do mLookatUpnodeRb.state = 1);
	3:(if mLookatAxisRb.state == myState do mLookatUpnodeRb.state = 2);
	)

);--end
*/
on mLookatAxisRb changed state do
(
	myState = state;
	case mLookatUpnodeRb.state of
	(
	1:(if mLookatUpnodeRb.state == myState do mLookatAxisRb.state = 2);
	2:(if mLookatUpnodeRb.state == myState do mLookatAxisRb.state = 1);
	3:(if mLookatUpnodeRb.state == myState do mLookatAxisRb.state = 2);
	)

);--end
on mLookatUpnodeRb changed state do
(
	myState = state;
	case mLookatAxisRb.state of
	(
	1:(if mLookatAxisRb.state == myState do mLookatUpnodeRb.state = 2);
	2:(if mLookatAxisRb.state == myState do mLookatUpnodeRb.state = 1);
	3:(if mLookatAxisRb.state == myState do mLookatUpnodeRb.state = 2);
	)

);--end
on mLookatPBt pressed do
(

	if selection.count != 0 and selection.count != 1 do
	(
	Local baseObj = selection[1];
	Local targetObj =  selection[2];
	Local myObj = point pos:baseObj.pos name:(baseObj.name + "_LookatPoint");
	Local myValue = 0;

	myObj.rotation.controller = LookAt_Constraint ();
	myObj.rotation.controller.appendTarget targetObj 50;
	myObj.rotation.controller.viewline_length_abs = off;
		case mLookatAxisRb.state of
		(
			1:(myObj.rotation.controller.target_axis = 0);
			2:(myObj.rotation.controller.target_axis = 1);
			3:(myObj.rotation.controller.target_axis = 2);
		)--end
		case mLookatUpnodeRb.state of
		(
			1:(myObj.rotation.controller.StoUP_axis = 0);
			2:(myObj.rotation.controller.StoUP_axis = 1);
			3:(myObj.rotation.controller.StoUP_axis = 2);
		)--end
		myValue = distance myObj targetObj;
	print myValue;
	
	);--if end
)