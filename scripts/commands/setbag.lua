-----------------------------------
-- func: setbag
-- desc: Sets the players bag size
-----------------------------------
local commandObj = {}

local bagparam =
{
    { bagsize = 30, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I    },
    { bagsize = 35, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II   },
    { bagsize = 40, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III  },
    { bagsize = 45, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV   },
    { bagsize = 50, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V    },
    { bagsize = 55, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI   },
    { bagsize = 60, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII  },
    { bagsize = 65, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII },
    { bagsize = 70, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX   },
    { bagsize = 75, questid = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X    },
    { bagsize = 80, questid = nil                                       },
}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!bagsize <30-80 and multiple of 5>')
end

commandObj.onTrigger = function(player, bagsize)
    -- Validate bag amount
    if bagsize < 30 or bagsize > 80 or (bagsize % 5 ~= 0) then
        error(player, 'Invalid bag size.')
        return
    end

    local currentBagSize = player:getContainerSize(xi.inv.INVENTORY)
    local adjustment = bagsize - currentBagSize

    for i = 1, 10 do
        if bagsize > bagparam[i].bagsize then
            player:completeQuest(xi.quest.log_id.JEUNO, bagparam[i].questid)
        else
            player:delQuest(xi.quest.log_id.JEUNO, bagparam[i].questid)
        end
    end

    -- Inform player and set bag size
    player:PrintToPlayer(string.format('Old Bag Size: %u', currentBagSize))
    player:PrintToPlayer(string.format('New Bag Size: %u', bagsize))
    player:changeContainerSize(xi.inv.INVENTORY, adjustment)
    player:changeContainerSize(xi.inv.MOGSATCHEL, adjustment)
end

return commandObj
