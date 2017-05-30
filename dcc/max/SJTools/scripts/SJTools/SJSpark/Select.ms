/**
 * -----------------------------------------------------------------------------
 *
 * SJ Tools
 *
 * -----------------------------------------------------------------------------
 * @license MIT
 * @author CaptainHansode �����D��
 * @web http://www.sakaiden.com/
 * @email sakaiden@live.jp
 * @github https://github.com/CaptainHansode/SJTools
 *
 */
group "Select"
(
    button selectAllBranchBt "�e�q�\����S�I��" width:160
)
on selectAllBranchBt pressed do
(
    with redraw off
    (
        --�K�w�\����S�Ď擾
        if selection.count != 0 then
        (
            --�ϐ�������
            local objRoot = selection[1],
            obj = undefined;
            objectBranch = #();--��������q��
            checkObj = undefined;--�`�F�b�N����I�u�W�F�N�g
            checkChildren = #();--�`�F�b�N����I�u�W�F�N�g�̔z��

            --�I���������̂̊K�w�������̂ڂ�A�e�I�u�W�F�N�g�������Ȃ�������
            while objRoot.parent != undefined do
            (
                objRoot = objRoot.parent
            )

            --�z��Ɋi�[
            append objectBranch objRoot

            --�q���̐�������
            numChild = objRoot.children.count;
            --�������
            for i =1 to objRoot.children.count do
            (
                --2�ɉ��
                append checkChildren objRoot.children[i];
                append objectBranch objRoot.children[i];
            )

            --0�ɂȂ�܂ŌJ��Ԃ�
            while numChild != 0 do
            (
                --deleteItem checkChildren 1;
                checkObj = checkChildren[numChild];
                --�`�F�b�N�p�z�񂩂�̂����肩��폜
                deleteItem checkChildren numChild;
                numChild -= 1;
                --�q�͂��邩�H
                if (checkObj.children.count != 0) then
                (
                    numChild += checkObj.children.count;--�J�E���g�A�b�v
                    for i =1 to checkObj.children.count do
                    (
                        append checkChildren checkObj.children[i];
                        append objectBranch checkObj.children[i];
                    )
                ) else (
                )
            )
            --�Ō�ɑI��
            select objectBranch;
            print "�I���I��";
        )
    )
)