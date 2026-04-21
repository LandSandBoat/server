-----------------------------------
-- Area: Riverne - Site B01
-- Mob: Ouryu
-- Notes: The Wyrmking Descends
-- !pos 184 0 344 30
-- Summons adds in a random order, these adds are not pets, but may be aggrod through usual methods like magic/sound.
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-----------------------------------
-- Adds in the Wyrmking Descends are summoned in a random order.
-----------------------------------
local addTable =
{
    [1] = ID.mob.BAHAMUT_V2 + 5, -- Ziryu
    [2] = ID.mob.BAHAMUT_V2 + 6, -- Ziryu
    [3] = ID.mob.BAHAMUT_V2 + 7, -- Ziryu
    [4] = ID.mob.BAHAMUT_V2 + 8, -- Ziryu
    [5] = ID.mob.BAHAMUT_V2 + 9, -- Water Elemental
    [6] = ID.mob.BAHAMUT_V2 + 10, -- Earth Elemental
}

-----------------------------------
-- Enter/Exit Flight Functions
-----------------------------------
local function enterFlight(mob)
    mob:setMobSkillAttack(425)
    mob:addStatusEffect(xi.effect.ALL_MISS, { power = 1, origin = mob, icon = 0 })
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setAnimationSub(1)
end

local function exitFlight(mob)
    mob:setMobSkillAttack(0)
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_1)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setAnimationSub(2)
end

-----------------------------------
-- Mistmelt Function
-----------------------------------
local function executeMistmelt(mob)
    if mob:getAnimationSub() == 1 then
        local currentTime = GetSystemTime()
        mob:setLocalVar('phaseChangeTime', currentTime + 120)
        mob:setLocalVar('phaseChangeHP', math.max(0, mob:getHP() - 2500))
        mob:injectActionPacket(mob:getID(), 11, 974, 0, 0x18, 0, 0, 0)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
        mob:setAnimationSub(2)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setMobSkillAttack(0)
    end

    mob:setLocalVar('mistmeltUsed', 0)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 80)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 52)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)

    mob:setLocalVar('phaseChangeHP', math.max(0, mob:getHP() - 2500))

    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local players = battlefield:getPlayers()
    for _, player in pairs(players) do
        if player:isAlive() then
            mob:updateEnmity(player)
            break
        end
    end

    -----------------------------------
    -- May use Invincible every 10 minutes starting at 85% HP
    -----------------------------------
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.INVINCIBLE_1, hpp = 85, cooldown = 600 },
        },
    })
end

entity.onMobEngage = function(mob)
    local currentTime = GetSystemTime()
    mob:setLocalVar('phaseChangeTime', currentTime + 120)
    mob:setLocalVar('addSpawnTime', currentTime + math.random(20, 30))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime = GetSystemTime()

    if mob:getLocalVar('mistmeltUsed') == 1 then
        executeMistmelt(mob)
        return
    end

    if
        currentTime >= mob:getLocalVar('phaseChangeTime') or
        mob:getHP() <= mob:getLocalVar('phaseChangeHP')
    then
        mob:setLocalVar('phaseChangeTime', currentTime + 120)
        mob:setLocalVar('phaseChangeHP', math.max(0, mob:getHP() - 2500))
        if mob:getAnimationSub() == 1 then
            exitFlight(mob)
        else
            enterFlight(mob)
        end
    end

    if currentTime >= mob:getLocalVar('addSpawnTime') then
        mob:setLocalVar('addSpawnTime', currentTime + math.random(60, 90))

        for _, randomAdd in ipairs(utils.shuffle(addTable)) do
            local addToSpawn = GetMobByID(randomAdd)
            if addToSpawn and addToSpawn:isDead() then
                addToSpawn:spawn()
                break
            end
        end
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if skillId == xi.mobSkill.OCHER_BLAST_ATTACK_2 then
        return 0
    end

    local skillList = {}

    -- Mid-flight.
    if mob:getAnimationSub() == 1 then
        table.insert(skillList, xi.mobSkill.OCHER_BLAST_2)
        table.insert(skillList, xi.mobSkill.BAI_WING_2)

    -- Ground.
    else
        table.insert(skillList, xi.mobSkill.TYPHOON_WING_2)
        table.insert(skillList, xi.mobSkill.SPIKE_FLAIL_7)
        table.insert(skillList, xi.mobSkill.GEOTIC_BREATH_2)
        table.insert(skillList, xi.mobSkill.ABSOLUTE_TERROR_7)
        table.insert(skillList, xi.mobSkill.HORRID_ROAR_7)
    end

    return skillList[math.random(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [2] = { xi.magic.spell.BREAK,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PETRIFICATION, 0, 100 },
        [3] = { xi.magic.spell.BREAKGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PETRIFICATION, 0, 100 },
        [4] = { xi.magic.spell.STONESKIN,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,     0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.EARTH,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDisengage = function(mob)
    if mob:getAnimationSub() == 1 then
        mob:setMobSkillAttack(0)
        mob:injectActionPacket(mob:getID(), 11, 974, 0, 0x18, 0, 0, 0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    mob:setAnimationSub(0)
end

return entity
