-----------------------------------
-- func: !addallatma
-- desc: Adds all Atma Key Items to the given player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local keyIds =
{
    -- Group 1
    1279, 1280, 1281, 1282, 1283, 1284, 1285, 1286, 1287, 1288, 1289,
    1290, 1291, 1292, 1293, 1294, 1295, 1296, 1297, 1298, 1299, 1300,
    1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310, 1311,
    1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322,
    1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333,
    1334, 1335, 1336, 1337, 1338, 1339, 1340, 1341, 1342, 1343, 1344,
    1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355,
    1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366,
    1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377,
    1378,

    -- Group 2
    1655, 1656, 1657, 1658, 1659, 1660, 1661, 1662, 1663, 1664, 1665,
    1666, 1667, 1668, 1669, 1670, 1671, 1672, 1673, 1674, 1675, 1676,
    1677, 1678, 1679, 1680, 1681, 1682, 1683, 1684, 1685, 1686, 1687,
    1688, 1689, 1690, 1691, 1692, 1693, 1694, 1695, 1696, 1697, 1698,
    1699,
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addallatma (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- add maps
    for _, v in ipairs(keyIds) do
        targ:addKeyItem(v)
    end

    player:printToPlayer(string.format('%s now has all Abyssea Atma.', targ:getName()))
end

return commandObj
