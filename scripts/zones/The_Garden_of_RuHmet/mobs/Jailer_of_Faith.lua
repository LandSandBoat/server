-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Faith
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
local gardenGlobal = require('scripts/zones/The_Garden_of_RuHmet/globals')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local function closeFlower(mob)
    mob:setAnimationSub(1)
    mob:setDelay(180)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.DMG, -2500) -- -25% damage taken with mouth closed
    mob:setLocalVar('changeTime', GetSystemTime() + 60)
end

local function openFlower(mob)
    mob:setAnimationSub(2)
    mob:setDelay(240)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DMG, 1250) -- +12.5% damage taken with mouth open
    mob:setLocalVar('changeTime', GetSystemTime() + 180)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 32)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    -- Spawn with flower closed.
    closeFlower(mob)

    mob:addMod(xi.mod.DEF, 100)
    mob:setMod(xi.mod.ATTP, 50)
    mob:setMod(xi.mod.MATT, 190)
    mob:setMod(xi.mod.STORETP, 100)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1) -- Never standback.

    -- Jailer of Faith uses Manafont 3 times, starting at 75% HP.
    xi.mix.jobSpecial.config(mob, {
        between  = 60,
        specials =
        {
            { id = xi.mobSkill.MANAFONT_1, hpp = 75 },
            { id = xi.mobSkill.MANAFONT_1, hpp = 50 },
            { id = xi.mobSkill.MANAFONT_1, hpp = 25 },
        },
    })

    -- We don't let mobs benefit from Occult Acumen currently, so we will code it as a listener manually.
    mob:addListener('MAGIC_USE', 'FAITH_OCCULT_ACUMEN', function(mobArg, target, spell, action)
        if
            action:getParam(action:getPrimaryTargetID()) > 0 and -- Param in this case is damage, and Occult Acumen requires atleast 1 damage.
            utils.contains(spell:getSkillType(), { xi.skill.ELEMENTAL_MAGIC, xi.skill.DARK_MAGIC })
        then
            mobArg:addTP(math.floor(spell:getMPCost() * 25 / 100 * (1 + 100 / 100))) -- Tier 1 Occult Acumen + 100 Store TP.
        end
    end)
end

entity.onMobFight = function(mob)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local changeTime = mob:getLocalVar('changeTime')

    if GetSystemTime() > changeTime then
        if mob:getAnimationSub() == 1 then
            openFlower(mob)
        else
            closeFlower(mob)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.SLOWGA,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLOW,          8, 100 },
        [2] = { xi.magic.spell.BREAKGA,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PETRIFICATION, 0, 100 },
        [3] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                     0, 100 },
        [4] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                     0, 100 },
    }

    -- Access to Quake II during Manafont only, with an increased weight.
    if mob:hasStatusEffect(xi.effect.MANAFONT) then
        table.insert(spellList, { xi.magic.spell.QUAKE_II, target, false, xi.action.type.DAMAGE_TARGET, nil, 0, 200 })
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDespawn = function(mob)
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FAITH):setPos(unpack(gardenGlobal.qmPosFaithTable[math.randomInt(1, 5)]))
end

return entity
