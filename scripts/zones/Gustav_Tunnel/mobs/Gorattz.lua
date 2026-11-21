-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Gorattz
-- Note: A Shantotto Ascension M6. The same script drives the agent and its three clones.
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.asa.helpers.onAgentSpawn(mob)
end

entity.onMobRoam = function(mob)
    xi.asa.helpers.onAgentTick(mob)
    xi.asa.helpers.onAgentCloneTick(mob)
end

entity.onMobFight = function(mob, target)
    xi.asa.helpers.onAgentTick(mob)
    xi.asa.helpers.onAgentCloneTick(mob)
end

-- The confrontation notices the last death and rewards the fighters.
entity.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar('cloneSlot') ~= 0 then
        return
    end

    if optParams.isKiller or optParams.noKiller then
        mob:messageText(mob, ID.text.GORATTZ_TOUGHER_THAN_SHE_LOOKS)
    end
end

return entity
