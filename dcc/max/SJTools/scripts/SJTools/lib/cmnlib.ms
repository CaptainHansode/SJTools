/**
 * -----------------------------------------------------------------------------
 *
 * SJTools common utility
 *
 * -----------------------------------------------------------------------------
 * (c) Copyright 2017 sakaiden and Captain Hansode. All rights reserved.
 * @license MIT
 * @author CaptainHansode 半袖船長
 * @web http://www.sakaiden.com/
 * @email sakaiden@live.jp
 * @git https://github.com/CaptainHansode/SJTools
 *
 * 汎用ユーティリティ
 *
 */
struct grpCmnUtil
(
    /**
    * get all
    */
    function getAllObjects =
    (
        return for i in objects collect i;
    ),

    /**
    * 小数点切り捨て
    */
    function decimalPointTruncation num digit =
    (
    digit = 0.1 * (pow10digit);
    returnfloor(num * digit)/digit;
    ),
    /**
    * 百分率
    * max値に対して現在何%なのか返す
    */
    function percentage maxVal cntVal =
    (
    returnfloor((100.0/maxVal) * cntVal);
    ),
    /**
    * ゼロ埋め
    */
    function zeroPadding num dig =
    (
    localzero = "0";
    fori=0todigdo(
    zero = zero + "0";
    )
    result = zero + (numasString);
    locals = (result.count - dig) + 1;
    returnsubstringresults -1;
    ),
    /**
    * undefined削除
    */
    function deleteUndefinedInArray inArray =
    (
    relust = #();
    foriininArraydo(
    ifi != undefineddo(
    appendrelusti;
    )
    )
    returnrelust;
    ),
    /**
    * 構造全部を取得
    */
    function getBranch obj =
    (
    --変数を準備
    localobjRoot = obj;
    localobjectBranch = #(); -- 回収した子供
    localcheckObj = undefined; -- チェックするオブジェクト
    localcheckChildren = #(); -- チェックするオブジェクトの配列
    --選択したものの階層をさかのぼり、親オブジェクトが無くなったら回収
    whileobjRoot.parent != undefineddo
    (
    objRoot = objRoot.parent;
    )
    appendobjectBranchobjRoot;
    -- 初期回収
    fori =1toobjRoot.children.countdo
    (
    appendcheckChildrenobjRoot.children[i];
    appendobjectBranchobjRoot.children[i];
    )
    -- 0になるまで繰り返す
    numChild = objRoot.children.count;
    whilenumChild != 0do
    (
    checkObj = checkChildren[numChild];
    -- チェック用配列からのおしりから削除
    deleteItemcheckChildrennumChild;
    numChild -= 1;
    -- 子はあるか？
    if(checkObj.children.count != 0)then
    (
    numChild += checkObj.children.count;--カウントアップ
    fori =1tocheckObj.children.countdo
    (
    appendcheckChildrencheckObj.children[i];
    appendobjectBranchcheckObj.children[i];
    )
    )
    )
    returnobjectBranch;
    ),
    /**
    * 全部のbip
    */
    function getAllBip =
    (
    localbips = #();
    allBips = #();
    --allBips = for i in objects collect if ((classOf i) == Biped_Object) do i.controller.rootNode;
    foriinobjectsdo(
    if((classOfi) == Biped_Object)do(
    appendIfUniquebipsi.controller.rootNode;
    )
    )
    foriinbipsdo(
    joinallBips(grpCmnUtil.getBranchi);
    )
    returnallBips;
    ),
    /**
    * 全カメラオブジェクトを取得
    */
    function getAllCamera =
    (
    localallObj = grpCmnUtil.getAllObjects();
    cameraList = #();
    localtypeList = #(Freecamera,
    Physical,
    Targetcamera,
    VRayDomeCamera,
    VRayPhysicalCamera
    );
    forobjinallObjdo
    (
    iffindItemtypeList(classOfobj) != 0do(
    appendcameraListobj;
    )
    )
    returncameraList;
    ),

    function getAllLight =
    (
        localallObj = grpCmnUtil.getAllObjects();
        lightList = #();
        -- なが！、なんか他に方法あった気が・・・
        localtypeList = #(Target_Light,
                          Free_Light,
                          mr_Sky_Portal,
                          Sun_Positioner,
                          targetSpot,
                          freeSpot,
                          TargetDirectionallight,
                          Directionallight,
                          Omnilight,
                          Skylight,
                          miAreaLightomni,
                          miAreaLight,
                          VRayLight,
                          VRayIES,
                          VRayAmbientLight,
                          VRaySun
                        );
    for obj in allObj do
    (
        if findItemtypeList(classOfobj) != 0do(
        append lightList obj;
    )
    )
    returnlightList;
    ),
    function getSceneNameWithoutExtention = (
    fileName = (FilterStringmaxFileName".")[1];
    iffileName == undefineddo(
    fileName = "";
    )
    returnfileName;
    )
)