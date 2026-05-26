-----------------------------------
-- Area: Balga's Dais
--  Mob: Gilagoge Tlugvi (WHM) "Spring Tree"
-- BCNM: Season's Greetings
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.SLOW_RES_RANK, 7)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 7)
    mob:setMod(xi.mod.BIND_RES_RANK, 7)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('benedictionTime', 0)
end

-- If it has been more than 2 minutes since Benediction was used, gain a significant damage boost.
entity.onMobFight = function(mob, target)
    if mob:getMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER) == 250 then
        return
    end

    local benedictionTime = mob:getLocalVar('benedictionTime')

    if
        benedictionTime > 0 and
        GetSystemTime() > benedictionTime + 120
    then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance  = 25,
        element = xi.element.DARK,
    }

    return xi.combat.action.executeAddEffectDispel(mob, target, pTable)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.ENTANGLE
end

-- If Benediction is used, the Monk tree (Goga Tlugvi) attacks.
entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillID = skill:getID()
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    if skillID == xi.mobSkill.BENEDICTION_1 then
        local currentTime = GetSystemTime()
        battlefield:setLocalVar('benedictionTime', currentTime)
        local baseId = mob:getID()
        local summerTree = GetMobByID(baseId + 1)

        if summerTree and summerTree:isAlive() then
            local currentTarget = mob:getTarget()
            if not currentTarget then
                return
            end

            summerTree:updateEnmity(currentTarget)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { spellId = xi.magic.spell.BANISH_III              },
        [ 2] = { spellId = xi.magic.spell.BANISHGA_II             },
        [ 3] = { spellId = xi.magic.spell.HOLY                    },
        [ 4] = { spellId = xi.magic.spell.CURE_V,     hp = 33     },
        [ 5] = { spellId = xi.magic.spell.CURAGA_II,  hp = 33     },
        [ 6] = { spellId = xi.magic.spell.BLINDNA                 },
        [ 7] = { spellId = xi.magic.spell.PARALYNA                },
        [ 8] = { spellId = xi.magic.spell.POISONA                 },
        [ 9] = { spellId = xi.magic.spell.SILENA                  },
        [10] = { spellId = xi.magic.spell.VIRUNA                  },
        [11] = { spellId = xi.magic.spell.VIRUNA                  },
        [12] = { spellId = xi.magic.spell.AQUAVEIL                },
        [13] = { spellId = xi.magic.spell.BLINK                   },
        [14] = { spellId = xi.magic.spell.PROTECT_IV, weight = 25 },
        [15] = { spellId = xi.magic.spell.SHELL_IV,   weight = 25 },
        [16] = { spellId = xi.magic.spell.DIA_II,     weight = 50 },
        [17] = { spellId = xi.magic.spell.DIAGA_II,   weight = 50 },
        [18] = { spellId = xi.magic.spell.PARALYZE                },
        [19] = { spellId = xi.magic.spell.SILENCE                 },
    }

    local allyList =
    {
        GetMobByID(mob:getID() + 1), -- Goga Tlugvi       (MNK) "Summer Tree"
        GetMobByID(mob:getID() + 2), -- Ulagohvsdi Tlugvi (NIN) "Autumn Tree"
        GetMobByID(mob:getID() + 3), -- Gola Tlugvi       (DRK) "Winter Tree"
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, allyList, nil)
end

return entity
