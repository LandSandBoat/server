-----------------------------------
-- Area : Horlais Peak
--  Mob : Invulnerable Mazzgozz
-- BCNM : Dismemberment Brigade
--  Mob : Paladin
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BANISH_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [2] = { xi.magic.spell.FLASH,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,   0, 100 },
        [3] = { xi.magic.spell.PROTECT_III, mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT, 0,  25 },
        [4] = { xi.magic.spell.SHELL_III,   mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,   0,  25 },
        [5] = { xi.magic.spell.CURE_IV,     mob,    true,  xi.action.type.HEALING_TARGET,    33,                0, 100 },
    }

    local groupTable =
    {
        GetMobByID(mob:getID() - 3), -- Armsmaster Dekbuk
        GetMobByID(mob:getID() - 2), -- Longarmed Gottditt
        GetMobByID(mob:getID() - 1), -- Keeneyed Aufwuf
        GetMobByID(mob:getID() + 1), -- Undefeatable Sappdapp
        GetMobByID(mob:getID() + 2), -- Minds-eyed Klugwug
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
