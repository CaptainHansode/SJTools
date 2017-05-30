/**
 * -----------------------------------------------------------------------------
 *
 * SJ Tools
 *
 * -----------------------------------------------------------------------------
 * @license MIT
 * @author CaptainHansode 半袖船長
 * @web http://www.sakaiden.com/
 * @email sakaiden@live.jp
 * @github https://github.com/CaptainHansode/SJTools
 *
 */

group "ヘルパーの見た目を一気に変更"
(
    button nuRseBt "表示変更" width:160  hight:20
    spinner nuRseNum "サイズ:" range:[0,1e+009,1] type:#float scale:0.01 width:160 align:#center
    checkbox changeMarkerCb "センターマーカ"
    checkbox changeAxistripodCb "座標軸"
    checkbox changeCrossCb "クロス"
    checkbox changeBoxCb "ボックス"
)

--表示変更
on nuRseBt pressed do
(
    for i = 1 to selection.count do
    (
        if classOf selection[i].baseobject == Point do --オブジェクトクラスがPointだった場合に
        (
            selection[i].size = nuRseNum.value;
            if changeMarkerCb.state == true then--Marker
            (
                selection[i].centermarker = on;
            ) else (
                selection[i].centermarker = off;
            )

            if changeAxistripodCb.state == true then--Axistripod
            (
                selection[i].axistripod = on;
            ) else (
                selection[i].axistripod = off;
            )

            if changeCrossCb.state == true then--Cross
            (
                selection[i].Cross = on;
            ) else (
                selection[i].Cross = off;
            )

            if changeBoxCb.state == true then--Box
            (
                selection[i].Box = on;
            ) else (
                selection[i].Box = off;
            )
        )
    )
)