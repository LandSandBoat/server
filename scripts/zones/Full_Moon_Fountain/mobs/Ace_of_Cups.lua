-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ace of Cups
-- Windurst Mission 9-2
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
-----------------------------------

function allMoonMobsDead(player)
    local inst = player:getBattlefield():getArea()
    local instOffset = ID.mob.MOON_READING_OFFSET + (6 * (inst - 1))
    for i = instOffset, instOffset + 3 do
        if not GetMobByID(i):isDead() then
            return false
        end
    end
    return true
end

function onMobDeath(mob, player, isKiller)
    if allMoonMobsDead(player) then
        player:release() -- prevents event collision if player kills multiple remaining mobs with an AOE move/spell
        player:startEvent(32004, 1, 0, 1, 0, 1)
    end
end
