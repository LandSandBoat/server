-----------------------------------
-- Module: Assault Mission and Promotion Limits
-- Only Private Second Class Assaults are available. Promotions stop at Superior Private.
-- No Promotion: Captain block yet because the quest is not yet implemented, so it cannot be called.
-- Players receive a message at the Assault counter NPCs telling them the current limits of available assaults.
-- Players receive a message at Abquhbah telling them the current promotion limits.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('assault_limits')

local maxAssaultRank   = xi.assault.mercenaryRank.PRIVATE_SECOND_CLASS
local maxPromotionRank = xi.assault.mercenaryRank.SUPERIOR_PRIVATE
local missionRanks     = {}
local instanceRanks    = {}

-- Every quest in the chain, so a GM-flagged one goes nowhere either.
local promotionQuests =
{
    [xi.assault.mercenaryRank.PRIVATE_FIRST_CLASS] = 'scripts/quests/ahtUrhgan/Promotion_Private_First_Class',
    [xi.assault.mercenaryRank.SUPERIOR_PRIVATE   ] = 'scripts/quests/ahtUrhgan/Promotion_Superior_Private',
    [xi.assault.mercenaryRank.LANCE_CORPORAL     ] = 'scripts/quests/ahtUrhgan/Promotion_Lance_Corporal',
    [xi.assault.mercenaryRank.CORPORAL           ] = 'scripts/quests/ahtUrhgan/Promotion_Corporal',
    [xi.assault.mercenaryRank.SERGEANT           ] = 'scripts/quests/ahtUrhgan/Promotion_Sergeant',
    [xi.assault.mercenaryRank.SERGEANT_MAJOR     ] = 'scripts/quests/ahtUrhgan/Promotion_Sergeant_Major',
    [xi.assault.mercenaryRank.CHIEF_SERGEANT     ] = 'scripts/quests/ahtUrhgan/Promotion_Chief_Sergeant',
    [xi.assault.mercenaryRank.SECOND_LIEUTENANT  ] = 'scripts/quests/ahtUrhgan/Promotion_Second_Lieutenant',
    [xi.assault.mercenaryRank.FIRST_LIEUTENANT   ] = 'scripts/quests/ahtUrhgan/Promotion_First_Lieutenant',
}

m:addOverride('xi.server.onServerStart', function()
    super()

    for assaultArea, missions in pairs(xi.assault.missionsByArea) do
        if assaultArea ~= xi.assault.assaultArea.NYZUL_ISLE then
            for rank, missionId in ipairs(missions) do
                missionRanks[missionId] = rank
            end
        end
    end

    for missionName, instanceId in pairs(xi.assault.instance) do
        instanceRanks[instanceId] = missionRanks[xi.assault.mission[missionName]]
    end

    for rank, questPath in pairs(promotionQuests) do
        if rank > maxPromotionRank then
            xi.module.modifyInteractionEntry(questPath, function(quest)
                -- Every section, not just the offer. First Lieutenant is offered by a trigger area with no NPC key.
                for _, section in ipairs(quest.sections) do
                    section.check = function()
                        return false
                    end
                end
            end)
        end
    end
end)

m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs.Abquhbah.onTrigger', function(player, npc)
    if xi.besieged.getMercenaryRank(player) >= maxPromotionRank then
        player:printToPlayer('You have reached the current promotion limit: Superior Private. Only Private Second Class Assault missions are currently available.', xi.msg.channel.SYSTEM_3)
    end

    super(player, npc)
end)

m:addOverride('xi.assault.onMissionGiverTrigger', function(player, npc, eventOffset, assaultArea)
    player:printToPlayer('Only Private Second Class Assault missions are currently available. The highest rank you can earn is Superior Private.', xi.msg.channel.SYSTEM_3)

    local rank = math.min(xi.besieged.getMercenaryRank(player), maxAssaultRank)
    if rank == 0 then
        return super(player, npc, eventOffset, assaultArea)
    end

    local active = xi.extravaganza.campaignActive()
    local cipher = 0

    if
        active == xi.extravaganza.campaign.SPRING_FALL or
        active == xi.extravaganza.campaign.BOTH
    then
        cipher = 1
    end

    player:startEvent(eventOffset, rank, player:hasKeyItem(xi.keyItem.IMPERIAL_ARMY_ID_TAG) and 1 or 0,
        player:getAssaultPoint(assaultArea), player:getCurrentAssault(), cipher)
end)

m:addOverride('xi.assault.onMissionGiverEventFinish', function(player, csid, option, npc, eventOffset, assaultArea)
    if csid == eventOffset and bit.band(option, 0xF) == 1 then
        local rank = missionRanks[bit.rshift(option, 4)]
        if
            not rank or
            rank > maxAssaultRank or
            rank > xi.besieged.getMercenaryRank(player)
        then
            return
        end
    end

    super(player, csid, option, npc, eventOffset, assaultArea)
end)

m:addOverride('xi.assault.checkRequirements', function(player, content)
    local rank = missionRanks[content.assaultID]
    if rank and rank > maxAssaultRank then
        return false
    end

    return super(player, content)
end)

m:addOverride('xi.instance.onEventUpdate', function(player, csid, option, npc)
    local rank = instanceRanks[player:getLocalVar('INSTANCE_ID')]
    if rank and rank > maxAssaultRank then
        player:instanceEntry(npc, 1)
        return false
    end

    return super(player, csid, option, npc)
end)
