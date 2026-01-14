-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Prishe
-- Chains of Promathia 8-4 BCNM Fight
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
mixins =
{
    require('scripts/mixins/helper_npc'),
    require('scripts/mixins/job_special'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

-- Helper NPC configuration
local helperConfig =
{
    engageWaitTime = 180, -- 3 minutes
    isAggroable    = true,
    targetMobs     = function(mob)
        local battlefieldArea = mob:getBattlefield():getArea()
        local areaOffset = (battlefieldArea - 1) * 2
        return
        {
            ID.mob.PROMATHIA + areaOffset,     -- Promathia
            ID.mob.PROMATHIA + areaOffset + 1, -- Promathia v2
        }
    end,
}

-- Prishe Item Usage
-- Uses item on engage and on a 2 1/2 minute timer
local itemActions =
{
    -- 1. Daedulus Wing: Usable at any time
    {
        condition = function(mob, phase)
            return true
        end,

        action = function(mob)
            mob:messageText(mob, ID.text.PRISHE_TEXT + 9, false)
            mob:useMobAbility(xi.mobSkill.ITEM_1_PRISHE)
            mob:setLocalVar('daedulus', 1)
        end,
    },

    -- 2. Bowl of Ambrosia: Usable in Phase 1
    {
        condition = function(mob, phase)
            return phase == 0
        end,

        action = function(mob)
            mob:addStatusEffect(xi.effect.FOOD, 0, 0, 150, 0, 0, 0, xi.effectSourceType.FOOD, 4511, mob:getID())
            mob:messageText(mob, ID.text.PRISHE_TEXT + 8, false)
            mob:useMobAbility(xi.mobSkill.ITEM_1_PRISHE)
        end,
    },

    -- 3. Carnal Incense (Physical Immunity): Only usable in phase 2
    {
        condition = function(mob, phase)
            return phase == 1
        end,

        action = function(mob)
            mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 30)
            mob:messageText(mob, ID.text.PRISHE_TEXT + 10, false)
            mob:useMobAbility(xi.mobSkill.ITEM_2_PRISHE)
        end,
    },

    -- 4. Spiritual Incense (Magical Immunity): Only usable in phase 2
    {
        condition = function(mob, phase)
            return phase == 1
        end,

        action = function(mob)
            mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 0, 30)
            mob:messageText(mob, ID.text.PRISHE_TEXT + 11, false)
            mob:useMobAbility(xi.mobSkill.ITEM_2_PRISHE)
        end,
    },

    -- 5. Remedy: Only usable in phase 2 if she has a status effect to be removed
    {
        condition = function(mob, phase)
            return phase == 1 and
                (mob:hasStatusEffect(xi.effect.PLAGUE) or
                    mob:hasStatusEffect(xi.effect.CURSE_I) or
                    mob:hasStatusEffect(xi.effect.SILENCE))
        end,

        action = function(mob)
            mob:messageText(mob, ID.text.PRISHE_TEXT + 12, false)
            mob:delStatusEffect(xi.effect.PLAGUE)
            mob:delStatusEffect(xi.effect.CURSE_I)
            mob:delStatusEffect(xi.effect.SILENCE)
            mob:useMobAbility(xi.mobSkill.ITEM_2_PRISHE)
        end,
    },
}

local function useItem(mob, phase)
    local battlefield = mob:getBattlefield()
    if battlefield then
        battlefield:setLocalVar('prisheItemTimer', GetSystemTime() + 150)
    end

    local validItems = {}
    for _, item in ipairs(itemActions) do
        if item.condition(mob, phase) then
            table.insert(validItems, item)
        end
    end

    if #validItems > 0 then
        local choice = validItems[math.random(1, #validItems)]
        choice.action(mob)
    end
end

entity.onMobSpawn = function(mob)
    xi.mix.helperNpc.config(mob, helperConfig)

    mob:setMobMod(xi.mobMod.NO_REST, 1)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 5)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    xi.mix.jobSpecial.config(mob,
        {
            specials =
            {
                { id = xi.jsa.HUNDRED_FISTS, hpp = 50 },
                { id = xi.jsa.BENEDICTION,   hpp = 10 },
            },
        })

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'PRISHE_SKILL_MSG', function(mobArg, skillID)
        local message =
        {
            [xi.mobSkill.AURORAL_UPPERCUT_1   ] = ID.text.PRISHE_TEXT + 4,
            [xi.mobSkill.NULLIFYING_DROPKICK_1] = ID.text.PRISHE_TEXT + 5,
            [xi.jsa.HUNDRED_FISTS             ] = ID.text.PRISHE_TEXT + 6,
            [xi.jsa.BENEDICTION               ] = ID.text.PRISHE_TEXT + 7,
        }

        if message[skillID] then
            mobArg:messageText(mobArg, message[skillID])
        end
    end)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'PRISHE_DAEDALUS', function(mobArg, skillID)
        -- Handle Daedulus Wing TP restoration
        if
            skillID == xi.mobSkill.ITEM_1_PRISHE and
            mobArg:getLocalVar('daedulus') == 1
        then
            mobArg:setTP(3000)
            mobArg:setLocalVar('daedulus', 0)
        end

        -- Reset animation sub after Nullifying Dropkick completes
        if skillID == xi.mobSkill.NULLIFYING_DROPKICK_1 then
            local target = mobArg:getTarget()
            if target then
                target:setAnimationSub(0)
            end
        end
    end)

    mob:addListener('MAGIC_TAKE', 'PRISHE_RAISE', function(prishe, caster, spell, action)
        if spell:getSpellFamily() ~= xi.magic.spellFamily.RAISE then
            return
        end

        -- Prishe waits a few seconds before getting up
        prishe:timer(5000, function(prisheArg)
            prisheArg:entityAnimationPacket(xi.animationString.SPECIAL_00)
            -- Give a few seconds for the special raise animation to play
            prisheArg:timer(4000, function(prisheArg2)
                prisheArg2:setHP(prisheArg2:getMaxHP())
                prisheArg2:resetAI() -- Exit the DEATH state
                prisheArg2:setAnimation(xi.animation.NONE)
                prisheArg2:messageText(prisheArg2, ID.text.PRISHE_TEXT + 3)
            end)
        end)
    end)
end

entity.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- React to Promathia taking first damage
    local reactPhase = battlefield:getLocalVar('prisheReact')
    if reactPhase > 0 then
        local messageOffset = reactPhase - 1  -- Phase 1 uses +0, Phase 2 uses +1
        battlefield:setLocalVar('prisheReact', 0)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setAutoAttackEnabled(false)
        mob:entityAnimationPacket('prov')
        mob:showText(mob, ID.text.PRISHE_TEXT + messageOffset)

        mob:timer(3000, function(prishe)
            prishe:setMobMod(xi.mobMod.NO_MOVE, 0)
            prishe:setAutoAttackEnabled(true)
            prishe:setLocalVar('useItem', 1)
        end)
    end

    -- Enough time has passed to use next item
    local itemTimer = battlefield:getLocalVar('prisheItemTimer')
    local phase = battlefield:getLocalVar('phase')
    if
        (itemTimer > 0 or mob:getLocalVar('useItem') == 1) and
        GetSystemTime() >= itemTimer
    then
        useItem(mob, phase)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    if
        target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return xi.mobSkill.NULLIFYING_DROPKICK_1
    else
        return xi.mobSkill.AURORAL_UPPERCUT_1
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local spellList =
    {
        [1] = { xi.magic.spell.BANISH_III,   target, false, xi.action.type.DAMAGE_TARGET,  nil, 0, 100 },
        [2] = { xi.magic.spell.BANISHGA_III, target, false, xi.action.type.DAMAGE_TARGET,  nil, 0, 100 },
        [3] = { xi.magic.spell.HOLY,         target, false, xi.action.type.DAMAGE_TARGET,  nil, 0, 100 },
        [4] = { xi.magic.spell.CURE_IV,      mob,    true,  xi.action.type.HEALING_TARGET,  33, 0, 100 },
    }

    local groupTable = battlefield:getPlayers()

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

entity.onMobDisengage = function(mob)
    local battlefield = mob:getBattlefield()
    if battlefield then
        battlefield:setLocalVar('prisheItemTimer', 0)
    end
end

entity.onMobDeath = function(mob, target, optParams)
    mob:messageText(mob, ID.text.PRISHE_TEXT + 2)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('PRISHE_SKILL_MSG')
    mob:removeListener('PRISHE_DAEDALUS')
    mob:removeListener('PRISHE_RAISE')
end

return entity
