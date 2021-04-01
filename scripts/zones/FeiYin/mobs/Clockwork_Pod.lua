-----------------------------------
-- Area: FeiYin
--  Mob: Clockwork Pod
-- Note: PH for Mind Hoarder
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    -- Curses, Foiled A-Golem!?
    if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
        player:delKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL)
        player:addKeyItem(xi.ki.SHANTOTTOS_EXSPELL)
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MIND_HOARDER_PH, 10, math.random(5400, 32400)) -- 1.5 to 9 hours
end

return entity
