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
local gateDamageSkills =
{
    [xi.mobSkill.FIRESPIT_BLUE_MAMOOLJA] = 1,
    [xi.mobSkill.AXE_THROW]               = 4,
    [xi.mobSkill.STAVE_TOSS]              = 4,
}

local whmRoamBuffs =
{
    xi.magic.spell.PROTECT_IV,
    xi.magic.spell.SHELL_IV,
    xi.magic.spell.BLINK,
    xi.magic.spell.STONESKIN,
    xi.magic.spell.AQUAVEIL,
    xi.magic.spell.HASTE,
    xi.magic.spell.BARBLIZZARA,
}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    local job = mob:getMainJob()

    -- The generic weapon_break mixin can remove the visible weapon after a
    -- critical hit even though no Stave Toss or Axe Throw occurred. That is
    -- misleading and can interfere with the mission presentation.
    mob:setLocalVar('BreakChance', 0)

    if job == xi.job.NIN then
        -- Keep NIN Warders in melee range so they engage gates.
        mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    elseif job == xi.job.BST then
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

        mob:addMod(xi.mod.MAIN_DMG_RATING, 45)
        mob:setMod(xi.mod.STR, 15)
        mob:setMod(xi.mod.ATT, 320)
    elseif job == xi.job.WHM then
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

-- Apply qualifying Warder weapon skills to nearby gates.
entity.onMobWeaponSkill = function(mob, target, skill, action)
    local hitValue = gateDamageSkills[skill:getID()]
    if not hitValue then
        return
    end

    -- Warder weapon skills have an 80% chance to damage the gate.
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
            -- Briefly reveal the gate before applying damage.
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
