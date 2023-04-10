-----------------------------------
-- New Character Cutscenes
-----------------------------------
require('scripts/globals/cutscenes')
require('scripts/globals/interaction/hidden_quest')
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------
local quest = HiddenQuest:new("newCharacterCS")

quest.reward = {}

-- Note:
-- Some areas swap order of when you get the Adventurer's coupon and the marker help text.
-- On retail, even if your inventory is full and change nations, the starting cutscene will attempt to give you the Adventurer's coupon and report your inventory is full.
quest.sections =
{
    {
        check = function(player, questVars, vars)
            return quest:getVar(player, 'notSeen') == 1 and xi.settings.main.NEW_CHARACTER_CUTSCENE == 1
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )

                    return { 0, -1, cutsceneFlags } -- CS 0 is not a typo.
                end
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    -- Retail normally zones you for this -- but testing proved there was no difference other than NOT zoning by just calling the next event.
                    -- event 0x00 fades your screen to black and seems to wait for another event, otherwise it will never fade back in.
                    -- TODO: research if there was some purpose to the zoning.

                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )

                    player:startEvent(7, { flags = cutsceneFlags })
                end,

                [7] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)

                    player:setPos(-280, -12, -90, 0)
                    player:setHomePoint()

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )
                    return { 1, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)

                    player:setPos(-45, -0, 25, 192)
                    player:setHomePoint()

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )
                    return { 1, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)

                    player:setPos(134, 8.5, -11, 96)
                    player:setHomePoint()

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )

                    return { 535, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [535] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)

                    player:setPos(0, 0, -12, 192)
                    player:setHomePoint()

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )

                    return { 503, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [503] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)

                    player:setPos(-100, 1, -40, 224) --cs exit
                    player:setHomePoint()

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )

                    return { 500, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [500] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)

                    player:setPos(-100, -8, -125, 224)
                    player:setHomePoint()

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.NO_NPCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )

                    return { 531, -1, cutsceneFlags }
                end
            },

            onEventUpdate =
            {
                [531] = function(player, csid, option, npc)
                    -- param 7 is checked in the event according to decomp, but it was never set on Hume F starting a new character.
                    -- param 7 was 0x20012 on a galka changing nations.
                    player:updateEvent({ [7] = 0 })
                end,
            },

            onEventFinish =
            {
                [531] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)

                    -- The HP position is slightly different than the CS exit.
                    player:setPos(-40.0, -5, 100, 64)
                    player:setHomePoint()
                    player:setPos(-40.611, -5, 102.5, 57) -- Move back to CS exit position

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.NO_NPCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )
                    return { 367, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [367] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)

                    player:setPos(30, 2, -40, 128)
                    player:setHomePoint()

                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local cutsceneFlags = bit.bor(
                        xi.cutscenes.params.UNKNOWN_1,
                        xi.cutscenes.params.NO_PCS,
                        xi.cutscenes.params.UNKNOWN_2
                    )

                    return { 305, -1, cutsceneFlags }
                end
            },

            onEventFinish =
            {
                [305] = function(player, csid, option, npc)
                    local ID = zones[player:getZoneID()]
                    player:messageText(player, ID.text.MAP_MARKER_TUTORIAL)
                    -- If you don't get the coupon, tough luck. Retail doesn't give you a chance to get it again.
                    npcUtil.giveItem(player, xi.items.ADVENTURERS_COUPON)

                    player:setPos(-120, -5.5, 175, 48)
                    player:setHomePoint()

                    player:setPos(-140, -7, 172, 32)
                    quest:setVar(player, 'notSeen', 0)
                end,
            },
        },
    },
}
return quest
