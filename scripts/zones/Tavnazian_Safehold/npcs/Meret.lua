-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Meret
-- !pos 83.166 -25.082 4.633 26
-----------------------------------
---@type TNpcEntity
local entity = {}

-- [tradedItemId] = rewardItemId
local trades =
{
    [xi.item.SAMPLE_OF_LUMINIAN_TISSUE] = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.PHUABO_ORGAN]              = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.XZOMIT_ORGAN]              = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.AERN_ORGAN]                = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.HPEMDE_ORGAN]              = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.YOVRA_ORGAN]               = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.EUVHI_ORGAN]               = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.LUMINION_CHIP]             = xi.item.VIRTUE_STONE_POUCH,
    [xi.item.VICE_OF_ANTIPATHY]         = xi.item.MERCIFUL_CAPE,
    [xi.item.VICE_OF_AVARICE]           = xi.item.ALTRUISTIC_CAPE,
    [xi.item.VICE_OF_ASPERSION]         = xi.item.ASTUTE_CAPE,
    [xi.item.AURA_OF_ADULATION]         = xi.item.NOVIO_EARRING,
    [xi.item.AURA_OF_VORACITY]          = xi.item.NOVIA_EARRING,
    [xi.item.SIN_OF_INDIGNATION]        = xi.item.NINURTAS_SASH,
    [xi.item.SIN_OF_INDOLENCE]          = xi.item.AUREOLE,
    [xi.item.SIN_OF_INDULGENCE]         = xi.item.FUTSUNO_MITAMA,
    [xi.item.SIN_OF_INVIDIOUSNESS]      = xi.item.RAPHAELS_ROD,
    [xi.item.SIN_OF_INSOLENCE]          = xi.item.MARSS_RING,
    [xi.item.SIN_OF_INFATUATION]        = xi.item.BELLONAS_RING,
    [xi.item.SIN_OF_INTEMPERANCE]       = xi.item.MINERVAS_RING,
}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE) == xi.questStatus.QUEST_COMPLETED then
        for k, v in pairs(trades) do
            if npcUtil.tradeHasExactly(trade, k) then
                player:setLocalVar('meretReward', v)
                player:startEvent(586, k, v)
                break
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_WARRIORS_PATH then
        if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE) == xi.questStatus.QUEST_COMPLETED then
            if math.random(1, 100) <= 50 then
                player:startEvent(582)
            else
                player:startEvent(583)
            end
        else
            player:startEvent(585)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 586 and option == player:getLocalVar('meretReward') then
        player:setLocalVar('meretReward', 0)

        if npcUtil.giveItem(player, option) then
            player:confirmTrade()
        end
    end
end

return entity
