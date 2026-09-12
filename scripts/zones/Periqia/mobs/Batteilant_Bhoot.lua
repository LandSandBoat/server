-----------------------------------
-- Area: Periqia
--  Mob: Batteilant Bhoot
-- Involved in Assault: Requiem
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.HPP, -10)
    mob:setMod(xi.mod.ATTP, 30)
    mob:setMod(xi.mod.MATT, 10)
    mob:setMod(xi.mod.STORETP, 5)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setBehavior(xi.behavior.STANDBACK)
end

-- Spell list is static and ignores level adjustments.
entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.ICE_SPIKES,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [2] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,       0, 100 },
        [3] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,      0, 100 },
        [4] = { xi.magic.spell.BLIZZARD_IV,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [5] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [6] = { xi.magic.spell.FREEZE,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if not instance then
            return
        end

        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
