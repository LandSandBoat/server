-----------------------------------
-- Area: Throne Room
--  Mob: Volker
-- Ally during Bastok Mission 9-2
-----------------------------------
local ID = zones[xi.zone.THRONE_ROOM]
mixins = { require('scripts/mixins/helper_npc') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Helper NPC configuration
local helperConfig =
{
    engageWaitTime = 90, -- 1.5 minutes
    isAggroable = false,
    targetMobs = function(mob)
        local battlefieldArea = mob:getBattlefield():getArea()
        local areaOffset = (battlefieldArea - 1) * 4
        return
        {
            ID.mob.ZEID_BCNM_OFFSET + areaOffset + 1, -- Zeid
            ID.mob.ZEID_BCNM_OFFSET + areaOffset + 2, -- Shadow_of_Rage
            ID.mob.ZEID_BCNM_OFFSET + areaOffset + 3, -- Shadow_of_Rage
        }
    end,
}

entity.onMobSpawn = function(volker)
    xi.mix.helperNpc.config(volker, helperConfig)

    volker:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mob, skillID)
        -- Red Lotus Blade
        if skillID == xi.mobSkill.VOLKER_RED_LOTUS_BLADE then
            mob:showText(mob, ID.text.NO_HIDE_AWAY)
            -- Spirits Within
        elseif skillID == xi.mobSkill.VOLKER_SPIRITS_WITHIN then
            mob:showText(mob, ID.text.YOUR_ANSWER)
            -- Vorpal Blade
        elseif skillID == xi.mobSkill.VOLKER_VORPAL_BLADE then
            mob:showText(mob, ID.text.CANT_UNDERSTAND)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:getBattlefield():lose()
        local players = mob:getBattlefield():getPlayers()
        for _, playerObj in pairs(players) do
            playerObj:messageSpecial(ID.text.UNABLE_TO_PROTECT)
        end
    end
end

return entity
