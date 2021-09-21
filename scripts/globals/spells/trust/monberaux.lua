-----------------------------------
-- Trust: Monberaux
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    -- TODO: Summon: I am Doctor Monberaux. My services are available for any affliction.
    -- TODO: Summon (1 dose of Final Elixir ready): I received a vial of a most valuable medicine. It should prove useful in times of emergency.
    -- TODO: Summon (2 doses of Final Elixir ready): I received two vials of a most valuable medicine. They should prove useful in times of emergency.
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)

    -- local healingMoveCooldown = 10

    -- Tends to be particular about which potions to use. Seems to favor healing for just the
    -- right amount of HP instead of defaulting to the highest-rank potion.
    -- mob:addSimpleGambit(ai.t.PARTY, ai.c.HP_MISSING, 500, ai.r.MS, ai.s.SPECIFIC, 4236, healingMoveCooldown) -- Max Potion

    mob:setAutoAttackEnabled(false)

    -- No TP for Monberaux
    mob:addListener("COMBAT_TICK", "MONBERAUX_CTICK", function(mobArg)
        mobArg:setTP(0)
    end)

    -- TODO: Monberaux's moves all come out with ACTION_ITEM_START and ACTION_ITEM_FINISH in their start/end action
    --     : packets, so we either need to fully implement a mob/trust's ability to use items (faking inventory space
    --     : etc.), or we need more workarounds like below to intercept and change the messages.
    --     : Currently, we only have enough bindings and triggers to change the action end packet.
    -- mob:addListener("WEAPONSKILL_USE", "MONBERAUX_ITEM_WEAPONSKILL_USE", function(mobArg, target, wsid, tp, action)
    --     action:setCategory(5) -- ACTION_ITEM_FINISH
    -- end)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
