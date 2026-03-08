-----------------------------------
-- Area: Jade Sepulcher
--   NM: Raubahn
-----------------------------------
local jadeSepulcherID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 18)
    mob:setMod(xi.mod.UFASTCAST, 70)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setMod(xi.mod.DMGMAGIC, -1250) -- Observed at 99 and the skillchain damage in under level 71 vods
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.AZURE_LORE_RAUBAHN, hpp = math.random(50, 95) },
        },
    })

    mob:addListener('TAKE_DAMAGE', 'RAUBAHN_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if damage >= 400 then -- Raubahn uses some sort of stat copy that isn't fully understood after days of testing.  I think it has to do with taking excessive damage.
            mob:messageText(mob, jadeSepulcherID.text.RAUBAHN_GREATER_POWER)
        end
    end)
end

entity.onMobRoam = function(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    if mob:getLocalVar('initialTaunt') == 1 then
        return
    end

    local players = battlefield:getPlayers()
    if not players[1] then
        return
    end

    if players[1]:checkDistance(mob) >= 10 then
        return
    end

    mob:setLocalVar('initialTaunt', 1)
    if players[1]:getLevelCap() >= 75 then -- On retail this message only plays if your cap is exactly 75. Treating this as an oversight.
        mob:messageText(mob, jadeSepulcherID.text.RAUBAHN_YOUR_SOUL)
    else
        mob:messageText(mob, jadeSepulcherID.text.RAUBAHN_COME_SURRENDER)
    end
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('engageTimer', 300)
    mob:setLocalVar('talkTime', GetSystemTime() + mob:getLocalVar('engageTimer'))

    if mob:getLocalVar('initialTaunt') == 1 then
        return
    end

    mob:setLocalVar('initialTaunt', 1)

    if target:getLevelCap() >= 75 then -- On retail this message only plays if your cap is exactly 75. Treating this as an oversight.
        mob:messageText(mob, jadeSepulcherID.text.RAUBAHN_YOUR_SOUL)
    else
        mob:messageText(mob, jadeSepulcherID.text.RAUBAHN_COME_SURRENDER)
    end
end

entity.onMobSpellChoose = function(mob, target, spell)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local playerLevel = battlefield:getLocalVar('playerLevel')

    local spellTable =
    {
        [1] = -- 70 and under
        {
            [1] = { xi.magic.spell.COCOON,          mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.DEFENSE_BOOST,   0, 100 },
            [2] = { xi.magic.spell.DIAMONDHIDE,     mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,       0, 100 },
            [3] = { xi.magic.spell.FEATHER_BARRIER, mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.EVASION_BOOST,   0, 100 },
            [4] = { xi.magic.spell.MEMENTO_MORI,    mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MAGIC_ATK_BOOST, 0, 100 },
            [5] = { xi.magic.spell.REFUELING,       mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.HASTE,           2, 100 },
        },
        [2] =  -- Over 70
        {
            [1] = { xi.magic.spell.AMPLIFICATION,   mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MAGIC_DEF_BOOST, 0, 100 },
            [2] = { xi.magic.spell.COCOON,          mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.DEFENSE_BOOST,   0, 100 },
            [3] = { xi.magic.spell.DIAMONDHIDE,     mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,       0, 100 },
            [4] = { xi.magic.spell.FEATHER_BARRIER, mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.EVASION_BOOST,   0, 100 },
            [5] = { xi.magic.spell.MEMENTO_MORI,    mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MAGIC_ATK_BOOST, 0, 100 },
            [6] = { xi.magic.spell.REFUELING,       mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.HASTE,           2, 100 },
        },
        [3] = -- 70 and under
        {
            [1]  = { xi.magic.spell.BLOOD_SABER,    target, false, xi.action.type.DRAIN_HP,           nil,                    0, 100 },
            [2]  = { xi.magic.spell.BLUDGEON,       target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [3]  = { xi.magic.spell.FRENETIC_RIP,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [4]  = { xi.magic.spell.FRIGHTFUL_ROAR, target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.DEFENSE_DOWN, 0, 100 },
            [5]  = { xi.magic.spell.GEIST_WALL,     target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [6]  = { xi.magic.spell.HEAD_BUTT,      target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [7]  = { xi.magic.spell.HEALING_BREEZE, mob,    false, xi.action.type.HEALING_FORCE_SELF, 100,                    0, 100 },
            [8]  = { xi.magic.spell.MAGIC_FRUIT,    mob,    false, xi.action.type.HEALING_FORCE_SELF, 100,                    0, 100 },
            [9]  = { xi.magic.spell.RADIANT_BREATH, target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [10] = { xi.magic.spell.SMITE_OF_RAGE,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [11] = { xi.magic.spell.TAIL_SLAP,      target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
        },
        [4] = -- Over 70
        {
            [1]  = { xi.magic.spell.BAD_BREATH,       target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [2]  = { xi.magic.spell.ENERVATION,       target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.DEFENSE_DOWN, 0, 100 },
            [3]  = { xi.magic.spell.EYES_ON_ME,       target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [4]  = { xi.magic.spell.FILAMENTED_HOLD,  target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SLOW,         1, 100 },
            [5]  = { xi.magic.spell.FROST_BREATH,     target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [6]  = { xi.magic.spell.HYSTERIC_BARRAGE, target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [7]  = { xi.magic.spell.MAGIC_FRUIT,      mob,    false, xi.action.type.HEALING_FORCE_SELF, 100,                    0, 100 },
            [8]  = { xi.magic.spell.SPINAL_CLEAVE,    target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [9]  = { xi.magic.spell.TAIL_SLAP,        target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [10] = { xi.magic.spell.THOUSAND_NEEDLES, target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
            [11] = { xi.magic.spell.UPPERCUT,         target, false, xi.action.type.DAMAGE_TARGET,      nil,                    0, 100 },
        },
    }

    local listIndex

    if mob:isEngaged() then
        listIndex = (playerLevel > 70) and 4 or 3
    else
        listIndex = (playerLevel > 70) and 2 or 1
    end

    local spellList = spellTable[listIndex]
    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onSpellCastStart = function(mob, target, spell)
    local spellMessage =
    {
        [1] = jadeSepulcherID.text.RAUBAHN_BE_BURIED,
        [2] = jadeSepulcherID.text.RAUBAHN_SHOW_ME,
    }

    if mob:isEngaged() then
        mob:showText(mob, spellMessage[math.random(1, #spellMessage)])
    end
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('alreadyTalked') == 0 and
        GetSystemTime() >= mob:getLocalVar('talkTime')
    then
        mob:setLocalVar('alreadyTalked', 1)
        mob:showText(mob, jadeSepulcherID.text.RAUBAHN_IT_IS_OVER) -- Sometimes this trigger will cause Raubahn to stop casting spells on retail, it's very buggy and I don't quite understand it.
        mob:setTP(3000)
    end

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local players = battlefield:getPlayers()
    if not players[1] then
        return
    end

    if mob:getHPP() < 20 then
        mob:showText(mob, jadeSepulcherID.text.RAUBAHN_STRENGTH_FAILED_ME)
        players[1]:disengage()
        mob:getBattlefield():win()
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local battlefield = mob:getBattlefield()
    local playerLevel = battlefield and battlefield:getLocalVar('playerLevel') or 99

    local tpTable =
    {
        xi.mobSkill.RED_LOTUS_BLADE_1,
        xi.mobSkill.FLAT_BLADE_1,
        xi.mobSkill.SERAPH_BLADE_1,
        xi.mobSkill.SPIRITS_WITHIN_1,
    }

    if playerLevel <= 67 then
        table.insert(tpTable, xi.mobSkill.FAST_BLADE_1)
    else
        table.insert(tpTable, xi.mobSkill.SAVAGE_BLADE_1)
    end

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillId = skill:getID()

    local skillMessage =
    {
        [xi.mobSkill.FAST_BLADE_1     ] = jadeSepulcherID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.RED_LOTUS_BLADE_1] = jadeSepulcherID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.FLAT_BLADE_1     ] = jadeSepulcherID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.SERAPH_BLADE_1   ] = jadeSepulcherID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.SPIRITS_WITHIN_1 ] = jadeSepulcherID.text.RAUBAHN_OUR_ARSENAL,
        [xi.mobSkill.SAVAGE_BLADE_1   ] = jadeSepulcherID.text.RAUBAHN_OUR_ARSENAL,
        [xi.jsa.AZURE_LORE_RAUBAHN    ] = jadeSepulcherID.text.RAUBAHN_AZURE_SAVEGERY,
    }

    if skillId == xi.jsa.AZURE_LORE_RAUBAHN then
        action:setCategory(xi.action.category.JOBABILITY_FINISH)
    end

    local messageId = skillMessage[skillId] or 0

    if messageId > 0 then
        mob:showText(mob, jadeSepulcherID.text.RAUBAHN_OUR_ARSENAL)
    end
end

entity.onMobDisengage = function(mob)
    mob:showText(mob, jadeSepulcherID.text.RAUBAHN_BEAST_OF_AMBITION)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('RAUBAHN_TAKE_DAMAGE')
end

return entity
