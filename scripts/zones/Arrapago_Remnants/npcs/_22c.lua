
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getInstance():getStage() == 4 then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventFinish = function(player, csid, option, door)
    if csid == 300 and option == 1 then
        local instance = door:getInstance()
        if not instance then
            return
        end

        instance:setStage(5)
        instance:setProgress(2)
        door:setAnimation(8)
        SpawnMob(ID.mob[4].treasure_hunter1, instance)
        SpawnMob(ID.mob[4].qiqirn_mine_1, instance)
        for _, v in pairs(ID.npc[4][1]) do
            local npc = GetNPCByID(v, instance)

            if npc then
                npc:setUntargetable(true)
            end
        end
    end
end

return entity
