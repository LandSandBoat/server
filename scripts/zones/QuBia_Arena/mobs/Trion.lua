-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Trion
-- Ally during San d'Oria Mission 9-2
-----------------------------------
local ID = zones[xi.zone.QUBIA_ARENA]
mixins = { require('scripts/mixins/helper_npc') }
-----------------------------------
---@type TMobEntity
local entity = {}

local helperConfig =
{
    engageWaitTime = 90,
    isAggrorable = false,
    targetMobs = function(mob)
        local battlefieldArea = mob:getBattlefield():getArea()
        local mobOffset       = ID.mob.WARLORD_ROJGNOJ + (battlefieldArea - 1) * 14

        local targetMobs      = {}
        for mobId = mobOffset, mobOffset + 2 do
            table.insert(targetMobs, mobId)
        end

        return targetMobs
    end,
}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 30)
end

entity.onMobSpawn = function(mob)
    xi.mix.helperNpc.config(mob, helperConfig)

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mobArg, skillID)
        -- Red Lotus Blade
        if skillID == xi.mobSkill.TRION_RED_LOTUS_BLADE then
            mobArg:showText(mobArg, ID.text.RLB_PREPARE)
            -- Flat Blade
        elseif skillID == xi.mobSkill.TRION_FLAT_BLADE then
            mobArg:showText(mobArg, ID.text.FLAT_PREPARE)
            -- Savage Blade
        elseif skillID == xi.mobSkill.TRION_SAVAGE_BLADE then
            mobArg:showText(mobArg, ID.text.SAVAGE_PREPARE)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:getBattlefield():lose()
end

return entity
