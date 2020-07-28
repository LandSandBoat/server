-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Karababa
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Navukgo_Execution_Chamber/IDs")
-----------------------------------

function onMobFight(mob, target)
    local warp = mob:getLocalVar("warp")
    local wait = mob:getLocalVar("wait")
    if mob:getLocalVar("warp") == 2 and wait < os.time() then
        mob:getBattlefield():lose()
    end
    if mob:getHPP() <= 50 and mob:getLocalVar("powerup") == 0 then
        target:showText(mob, ID.text.KARABABA_ENOUGH)
        target:showText(mob, ID.text.KARABABA_ROUGH)
        mob:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, 15, 0, 1800)
        mob:setLocalVar("powerup", 1)
    elseif mob:getHPP() <= 20 and warp == 0 then
        mob:setLocalVar("warp", 1)
    end
end

function onMonsterMagicPrepare(mob, target)
    local powerup = mob:getLocalVar("powerup")
    local rnd = math.random(1, 6)
    local warp = mob:getLocalVar("warp")

    if warp == 1 then
        mob:showText(mob, ID.text.KARABABA_QUIT)
        mob:setLocalVar("warp", 2)
        mob:setLocalVar("wait", os.time()+8)
        return 261
    elseif rnd == 1 then
        mob:showText(mob, ID.text.KARABARA_FIRE)
        return 205 - powerup
    elseif rnd == 2 then
        mob:showText(mob, ID.text.KARABARA_ICE)
        return 207 - powerup
    elseif rnd == 3 then
        mob:showText(mob, ID.text.KARABARA_WIND)
        return 209 - powerup
    elseif rnd == 4 then
        mob:showText(mob, ID.text.KARABARA_EARTH)
        return 211 - powerup
    elseif rnd == 5 then
        mob:showText(mob, ID.text.KARABARA_LIGHTNING)
        return 213 - powerup
    elseif rnd == 6 then
        mob:showText(mob, ID.text.KARABARA_WATER)
        return 215 - powerup
    end
end

function onMobDeath(mob, player, isKiller)
    mob:getBattlefield():lose()
end
