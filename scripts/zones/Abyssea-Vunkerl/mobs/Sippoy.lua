-----------------------------------
-- Area: Abyssea - Vunkerl
--   NM: Sippoy
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 50 then
        mob:setMobMod(xi.mobMod.SPELL_LIST, 159)
    else
        -- I'm assuming that if it heals up, it goes back to the its original spell list.
        mob:setMobMod(xi.mobMod.SPELL_LIST, 158)
        -- This 'else' can be removed if that isn't the case, and a localVar added so it only execs once.
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SIPPOY_CAPTURER)
end

return entity
