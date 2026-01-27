-----------------------------------
-- Area : Boneyard Gully
-- Mob  : Nepionic Bladmall
-- ENM  : Shell We Dance?
-- NOTE : These Uragnites do not go into their shell
-----------------------------------
---@type TMobEntity
local entity = {}

-----------------------------------
-- onMobInitialize
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:setBehavior(xi.behavior.STANDBACK)
end

-----------------------------------
-- onMobSpawn
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 0)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, math.random(3, 7))
end

-----------------------------------
-- Spell Selection
-----------------------------------
entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.WATER_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [2] = { xi.magic.spell.WATERGA_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [3] = { xi.magic.spell.CURE_IV,    mob,    false, xi.action.type.HEALING_TARGET,       50,                  0, 100 },
        [4] = { xi.magic.spell.SLOWGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,      4, 100 },
        [5] = { xi.magic.spell.BLINDGA,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS, 0, 100 },
        [6] = { xi.magic.spell.PROTECT_IV, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PROTECT,   0,  25 },
        [7] = { xi.magic.spell.SHELL_IV,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHELL,     0,  25 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
