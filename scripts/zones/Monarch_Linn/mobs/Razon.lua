-----------------------------------
-- Area : Monarch Linn
-- Mob  : Razon
-- ENM  : Fire in the Sky
-----------------------------------
local ID = zones[xi.zone.MONARCH_LINN]
-----------------------------------
---@type TMobEntity
local entity = {}

local elementData =
{
    [xi.damageType.FIRE]    = { animation = 432 },
    [xi.damageType.ICE]     = { animation = 433 },
    [xi.damageType.WIND]    = { animation = 434 },
    [xi.damageType.EARTH]   = { animation = 435 },
    [xi.damageType.THUNDER] = { animation = 436 },
    [xi.damageType.WATER]   = { animation = 437 },
    [xi.damageType.LIGHT]   = { animation = 438 },
    [xi.damageType.DARK]    = { animation = 439 },
}

-- Phase changes happen from triggered element or HP thresholds, last self destruct can only be triggered by element.
local phases =
{
    [1] = { threshold = 66,  skill = xi.mobSkill.SELF_DESTRUCT_CLUSTER_3     },
    [2] = { threshold = 33,  skill = xi.mobSkill.SELF_DESTRUCT_CLUSTER_2     },
    [3] = { threshold = nil, skill = xi.mobSkill.SELF_DESTRUCT_CLUSTER_RAZON },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMobMod(xi.mobMod.MAGIC_RANGE, 40)

    -- When the final self destruct is triggered, all players get kicked out of the battlefield immediately
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'FINAL_SELF_DESTRUCT', function(mobArg, skillId, wasExecuted)
        if skillId ~= xi.mobSkill.SELF_DESTRUCT_CLUSTER_RAZON then
            return
        end

        local battlefield = mobArg:getBattlefield()
        if not battlefield then
            return
        end

        for _, player in pairs(battlefield:getPlayers()) do
            player:messageSpecial(ID.text.KNOCKED_OUT_OF_BATTLEFIELD)
        end

        battlefield:cleanup(true)
    end)

    mob:addListener('TAKE_DAMAGE', 'RAZON_DEALT_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if not attacker then
            return
        end

        -- Avatars blood pacts can't trigger the self destruct (TODO: Jug pets too?)
        if attacker:isAvatar() then
            return
        end

        -- Should never be an issue, but just in case.
        if damageType < xi.damageType.FIRE then
            return
        end

        local triggerElement1 = mobArg:getLocalVar('triggerElement1')
        local triggerElement2 = mobArg:getLocalVar('triggerElement2')

        if damageType == triggerElement1 or damageType == triggerElement2 then
            mobArg:setLocalVar('elementTriggered', damageType)
        end
    end)
end

-- Setup selected elements for self destructs, set phase as a battlefield var so it can be checked in the battlefield lua for victory conditions.
entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, 10000)
    mob:setMod(xi.mod.UDMGPHYS, -9500)

    local elements = {}
    for element, _ in pairs(elementData) do
        table.insert(elements, element)
    end

    local shuffledElements = utils.permgen(#elements, 1)
    mob:setLocalVar('triggerElement1', elements[shuffledElements[1]])
    mob:setLocalVar('triggerElement2', elements[shuffledElements[2]])
    mob:setLocalVar('elementTriggered', 0)

    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    battlefield:setLocalVar('phase', 1)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local phaseData = phases[battlefield:getLocalVar('phase')]
    if not phaseData then
        return
    end

    local elementTriggered = mob:getLocalVar('elementTriggered')
    if
        elementTriggered == 0 and
        (not phaseData.threshold or mob:getHPP() > phaseData.threshold)
    then
        return
    end

    if mob:checkDistance(target) > 10 then
        return
    end

    -- If phase change is triggered by an element, inject colored dust cloud animation alongside self destruct
    if elementTriggered > 0 then
        mob:injectActionPacket(mob:getID(), 11, elementData[elementTriggered].animation, 0, 0x18, 0, 0, 0)
    end

    mob:useMobAbility(phaseData.skill)

    battlefield:setLocalVar('phase', battlefield:getLocalVar('phase') + 1)

    mob:setLocalVar('elementTriggered', 0)
end

return entity
