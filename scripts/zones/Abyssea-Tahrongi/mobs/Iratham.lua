-----------------------------------
-- Area: Abyssea - Tahrongi
--   NM: Iratham
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 20 then
        mob:setMobMod(xi.mobMod.SPELL_LIST, 155)
    elseif mob:getHPP() < 50 then
        mob:setMobMod(xi.mobMod.SPELL_LIST, 154)
    else
        -- I'm assuming that if it heals up, it goes back to the its original spell list.
        mob:setMobMod(xi.mobMod.SPELL_LIST, 153)
        -- This 'else' can be removed if that isn't the case, and a localVar added so it only execs once.
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.IRATHAM_CAPTURER)
end

return entity
