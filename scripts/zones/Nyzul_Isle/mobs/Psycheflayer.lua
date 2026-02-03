-----------------------------------
--  MOB: Psycheflayer
-- Area: Nyzul Isle
-- Info: Specified Mob Group and Eliminate all Group
-----------------------------------
mixins = { require('scripts/mixins/families/soulflayer') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.nyzul.specifiedEnemySet(mob)

    -- There was a mob pool check for 8072 here but that doesn't exist anymore so it was removed.
    -- If I had to guess it was for Nyzul Isle and is now obsolete?
end

entity.onMobMobskillChoose = function(mob, target)
    local shield = mob:getLocalVar('immortalShieldStacks')
    local tpList =
    {
        xi.mobSkill.MIND_BLAST,
        xi.mobSkill.TRIBULATION,
        xi.mobSkill.IMMORTAL_ANATHEMA,
    }

    -- Add mind purge only if target has dispellable effects
    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(tpList, xi.mobSkill.MIND_PURGE)
    end

    -- Add immortal shield if below max stacks
    if shield < 2 then
        table.insert(tpList, xi.mobSkill.IMMORTAL_SHIELD)
    end

    -- Add immortal mind if there are 3+ allies within 10 yalms
    local allyCount = 0
    for _, otherMob in pairs(mob:getZone():getMobs()) do
        if
            otherMob:getID() ~= mob:getID() and
            otherMob:isAlive() and
            mob:checkDistance(otherMob) <= 10
        then
            allyCount = allyCount + 1
        end
    end

    if allyCount >= 3 then
        table.insert(tpList, xi.mobSkill.IMMORTAL_MIND)
    end

    return tpList[math.random(1, #tpList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedEnemyKill(mob)

        if mob:getID() >= 17092974 then
            xi.nyzul.specifiedGroupKill(mob)
        end
    end
end

return entity
