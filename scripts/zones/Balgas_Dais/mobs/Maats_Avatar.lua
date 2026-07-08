-----------------------------------
-- Area: Balga's Dais
--  Mob: Maat's Avatar
-- Genkai 5 Fight
-----------------------------------
require('scripts/globals/pets/summon')
-----------------------------------
---@type TMobEntity
local entity = {}

local possibleAvatars =
{
    xi.pets.summon.type.CARBUNCLE,
    xi.pets.summon.type.IFRIT,
    xi.pets.summon.type.TITAN,
    xi.pets.summon.type.LEVIATHAN,
    xi.pets.summon.type.GARUDA,
    xi.pets.summon.type.SHIVA,
    xi.pets.summon.type.RAMUH,
}

entity.onMobSpawn = function(mob)
    xi.pets.summon.setupSummon(mob, possibleAvatars)

    xi.combat.behavior.enableAllActions(mob)
end

entity.onMobFight = function(mob, target)
    -- If the Avatar is asleep, or unable to act, do nothing.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if
        mob:getLocalVar('astralFlowUsed') == 1 and
        mob:checkDistance(target) <= 25
    then
        mob:useMobAbility(mob:getLocalVar('astralFlowId'))
        mob:setLocalVar('astralFlowUsed', 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local maat = mob:getMaster()

        if not maat then
            return
        end

        maat:setLocalVar('petSummonTime', GetSystemTime() + 30)
    end
end

return entity
