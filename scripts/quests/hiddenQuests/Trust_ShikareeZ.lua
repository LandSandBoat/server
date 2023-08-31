-----------------------------------
-- Trust: Shikaree Z
-----------------------------------
-- Perih Vashai !gotoid 17764470 / !pos 117.5 -3.7 90.453 241
-----------------------------------
local woodsID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------

local quest = HiddenQuest:new('TrustShikareeZ')

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return not player:hasSpell(xi.magic.spell.SHIKAREE_Z) and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS) and
                -- TODO BG WIKI States acquisition can be blocked while Shikaree Z is "out of town".
                --      Verify which Missions this comment refers to, though likely the following:
                --      FLAMES_IN_THE_DARKNESS, FIRE_IN_THE_EYES_OF_MEN, A_FATE_DECIDED
                --      https://www.bg-wiki.com/ffxi/Promathia_Mission_5-3
                --      https://www.bg-wiki.com/ffxi/BGWiki:Trusts#Shikaree_Z
                not (player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.FLAMES_IN_THE_DARKNESS and
                player:getCurrentMission(xi.mission.log_id.COP) <= xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN) and
                player:getCurrentMission(xi.mission.log_id.COP) ~= xi.mission.id.cop.A_FATE_DECIDED and
                player:hasKeyItem(xi.ki.WINDURST_TRUST_PERMIT)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(869)
                end,
            },

            onEventFinish =
            {
                [869] = function(player, csid, option, npc)
                    if xi.trust.hasPermit(player) then
                        player:addSpell(xi.magic.spell.SHIKAREE_Z, true, true)
                        player:messageSpecial(woodsID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.SHIKAREE_Z)
                    end
                end,
            },
        },
    },
}

return quest
