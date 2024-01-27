-----------------------------------
-- Trust: Ingrid
-----------------------------------
local easternAdoulinID = zones[xi.zone.EASTERN_ADOULIN]
-----------------------------------

local quest = HiddenQuest:new('TrustIngrid')

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return not player:hasSpell(xi.magic.spell.INGRID) and
                player:hasCompletedMission(xi.mission.log_id.SOA, xi.mission.id.soa.THE_MERCILESS_ONE)
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Rigobertine'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: These parameters may have no impact on the event, and were captured
                    -- immediately after completing "The Merciless One" and receiving eternal flame
                    -- keyitem.

                    return quest:event(5062, 257, 0, 0, 255, 255, 4352, 1)
                end,
            },

            onEventFinish =
            {
                [5062] = function(player, csid, option, npc)
                    if option == 2 then
                        player:addSpell(xi.magic.spell.INGRID, true, true)

                        player:messageSpecial(easternAdoulinID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.INGRID)
                    end
                end,
            },
        },
    },
}

return quest
