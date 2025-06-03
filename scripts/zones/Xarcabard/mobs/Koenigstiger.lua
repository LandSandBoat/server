-----------------------------------
-- Area: Xarcabard
--  Mob: Koenigstiger
-- Involved in Quests: Unbridled Passion (RNG AF3)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 240)
end

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar('unbridledPassion') == 4 then
        player:setCharVar('unbridledPassion', 5)
    end
end

return entity
