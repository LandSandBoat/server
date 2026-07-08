-----------------------------------
-- Area: Mog Dinghy
-- !zone 280
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: Cap and figure this out
    player:startEvent(1015, 1, 1, 1, 1, 1, 1, 1, 1)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1015 then
        -- TODO: Capture correct exit positions for all of these
        if option == 1 then -- 1: Whence I came
            player:warp() -- TODO: Workaround for now, the last zone seems to get messed up due to mog house issues.
        elseif option == 2 then -- 2: Western Adoulin
            player:setPos(0, 0, 0, 0, xi.zone.WESTERN_ADOULIN)
        elseif option == 3 then -- 3: Eastern Adoulin
            player:setPos(0, 0, 0, 0, xi.zone.EASTERN_ADOULIN)
        end
    elseif csid == 1089 then
        -- TODO
    end
end

return entity
