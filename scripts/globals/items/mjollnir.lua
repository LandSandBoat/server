-----------------------------------------
-- ID: 18324, 18325, 18647, 18661, 18675, 19756, 19849, 21060, 21061, 21077
-- Item: Mjollnir
-- Additional Effect: Recover MP
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if math.random(100) <= chance then
        local mp = math.random(4, 16)
        player:addMP(mp)
        player:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, mp)
    end

    return 0, 0, 0
end
