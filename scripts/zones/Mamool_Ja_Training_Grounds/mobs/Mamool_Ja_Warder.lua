-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Warder (NIN, WHM, BST)
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Gate durability is represented as four points:
-- Firespit = 1 point; Axe Throw / Stave Toss = 4 points.
-- Both known Stave Toss IDs are accepted while this old Assault is being
-- brought forward to the current LSB combat hooks.
local gateSkillDamage =
{
    [1733] = 1, -- Firespit
    [1923] = 1, -- Firespit (alternate Mamool family skill)
    [1736] = 4, -- Axe Throw
    [1925] = 4, -- Stave Toss in current Omega data
    [2361] = 4, -- Stave Toss in the original Wings implementation
}

local whmRoamBuffs =
{
    46, -- Protect IV
    51, -- Shell IV
    53, -- Blink
    54, -- Stoneskin
    55, -- Aquaveil
    57, -- Haste
    67, -- Barblizzara
}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    -- Skill selection is data-driven through the mission-specific mob pools.
    -- Do not override SKILL_LIST here; the BST and NIN pools use the restricted
    -- Imperial Agent Rescue lists defined in sql/mob_skill_lists.sql.

    -- The generic weapon_break mixin can remove the visible weapon after a
    -- critical hit even though no Stave Toss or Axe Throw occurred. That is
    -- misleading and can interfere with the mission presentation.
    mob:setLocalVar('BreakChance', 0)

    if mob:getMainJob() == xi.job.NIN then
        -- NIN Warders otherwise remain at ranged-attack distance and are very
        -- difficult to position toward a gate.
        mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    elseif mob:getMainJob() == xi.job.BST then
        local instance = mob:getInstance()
        local petId = mob:getID() + 1
        local pet = GetMobByID(petId, instance)

        if pet then
            mob:setPet(pet)
            mob:timer(5000, function(mobArg)
                local currentPet = GetMobByID(petId, instance)
                if not currentPet then
                    return
                end

                local pos = mobArg:getPos()
                currentPet:setSpawn(
                    pos.x + math.randomInt(-2, 2),
                    pos.y,
                    pos.z + math.randomInt(-2, 2)
                )
                SpawnMob(petId, instance)
            end)
        end

        -- These mission-specific combat values existed in the original
        -- implementation and prevent the Warders from behaving like weak,
        -- incomplete placeholder mobs.
        mob:addMod(xi.mod.MAIN_DMG_RATING, 45)
        mob:setMod(xi.mod.STR, 15)
        mob:setMod(xi.mod.ATT, 320)
    elseif mob:getMainJob() == xi.job.WHM then
        mob:addMod(xi.mod.MAIN_DMG_RATING, 35)
        mob:setMod(xi.mod.STR, 10)
        mob:setMod(xi.mod.ATT, 270)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getMainJob() ~= xi.job.BST then
        return
    end

    local pet = GetMobByID(mob:getID() + 1, mob:getInstance())
    if pet and pet:getCurrentAction() == xi.action.category.ROAMING then
        pet:updateEnmity(target)
    end
end

entity.onMobRoam = function(mob)
    if
        mob:getMainJob() ~= xi.job.WHM or
        mob:getCurrentAction() ~= xi.action.category.ROAMING
    then
        return
    end

    local cooldown = mob:getLocalVar('magicBuffCooldown')
    if cooldown == 0 then
        mob:castSpell(whmRoamBuffs[math.randomInt(1, #whmRoamBuffs)], mob)
        mob:setLocalVar('magicBuffCooldown', math.randomInt(3, 5))
    else
        mob:setLocalVar('magicBuffCooldown', cooldown - 1)
    end
end

-- Current LSB calls this after the mob weapon skill resolves as:
-- (mob, target, skill, action).
--
-- Do not redirect the actual combat target and do not synthesize an engine
-- WEAPONSKILL_TAKE event. Instead, update the instance-owned gate directly.
entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillId = skill:getID()
    local hitValue = gateSkillDamage[skillId]
    if not hitValue then
        return
    end

    -- Original mission behavior allows the move to miss the gate even when
    -- the Warder is positioned correctly.
    if math.randomInt(1, 100) > 80 then
        return
    end

    local instance = mob:getInstance()
    if not instance then
        return
    end

    for _, gateId in ipairs(ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE].GATES) do
        local gate = GetMobByID(gateId, instance)
        if
            gate and
            gate:isAlive() and
            mob:checkDistance(gate) <= 10 and
            mob:isFacing(gate)
        then
            -- Preserve the short visual delay from the original mission.
            gate:hideName(false)
            gate:timer(1, function(gateArg)
                gateArg:hideName(true)
            end)

            gate:timer(2000, function(gateArg)
                if not gateArg:isAlive() then
                    return
                end

                local newHits = gateArg:getLocalVar('hits') + hitValue
                gateArg:setLocalVar('hits', newHits)

                if newHits >= 4 then
                    gateArg:setHP(0)
                end
            end)

            return
        end
    end
end

return entity
