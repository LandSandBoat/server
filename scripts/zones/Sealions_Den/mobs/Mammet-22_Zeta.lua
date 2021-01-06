-----------------------------------
-- Area: Sealions Den
--  Mob: Mammet-22 Zeta
-----------------------------------
local ID = require("scripts/zones/Sealions_Den/IDs")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobDeath(mob, player, isKiller)
    -- find mob offset for given battlefield instance
    local inst = mob:getBattlefield():getArea()
    local instOffset = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (inst - 1))

    -- if all five mammets in this instance are dead, start event
    local allMammetsDead = true
    for i = instOffset + 0, instOffset + 4 do
        if not GetMobByID(i):isDead() then
            allMammetsDead = false
            break
        end
    end
    if allMammetsDead then
        player:release() -- prevents event collision if player kills multiple remaining mammets with an AOE move/spell
        player:startEvent(11)
    end
end

function onEventFinish(player, csid, option)
    if csid == 11 then
        local battlefield = player:getBattlefield()
        local inst = battlefield:getArea()
        -- players are healed in between fights, but their TP is set to 0
        player:addTitle(tpz.title.BRANDED_BY_LIGHTNING)
        player:setHP(player:getMaxHP())
        player:setMP(player:getMaxMP())
        player:setTP(0)
        player:setLocalVar("[OTBF]cs", 1)

        -- move player to instance
        if inst == 1 then
            player:setPos(-779, -103, -80)
        elseif inst == 2 then
            player:setPos(-140, -23, -440)
        elseif inst == 3 then
            player:setPos(499, 56, -802)
        end
    end
end

return entity
