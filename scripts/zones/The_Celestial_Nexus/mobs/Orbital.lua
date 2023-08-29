-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Orbital
-- Zilart Mission 16 BCNM Fight
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 32004 then
        if GetMobByID(npc:getID() - 1):getName() == 'Orbital' then
            DespawnMob(npc:getID())
            DespawnMob(npc:getID() - 1)
            DespawnMob(npc:getID() - 3)
            DespawnMob(npc:getID() - 4)
            local mob = SpawnMob(npc:getID()-2)
            mob:updateEnmity(player)
            --the '30 seconds of rest' you get before he attacks you, and making sure he teleports first in range
            mob:addStatusEffectEx(xi.effect.BIND, 0, 1, 0, 30)
            mob:addStatusEffectEx(xi.effect.SILENCE, 0, 1, 0, 40)
        else
            DespawnMob(npc:getID())
            DespawnMob(npc:getID() + 1)
            DespawnMob(npc:getID() - 2)
            DespawnMob(npc:getID() - 3)
            local mob = SpawnMob(npc:getID()-1)
            mob:updateEnmity(player)
            -- the '30 seconds of rest' you get before he attacks you, and making sure he teleports first in range
            mob:addStatusEffectEx(xi.effect.BIND, 0, 1, 0, 30)
            mob:addStatusEffectEx(xi.effect.SILENCE, 0, 1, 0, 40)
        end
    end
end

return entity
