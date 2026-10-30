-----------------------------------
-- Area: Leujaoam Sanctum
-- Mulwahah
-----------------------------------
local ID = zones[xi.zone.LEUJAOAM_SANCTUM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if not instance then
        return
    end

    -- Hand-in the orichalcum ore with the same pacing as retail.
    if player:hasItem(xi.item.CHUNK_OF_ORICHALCUM_ORE, xi.inv.TEMPITEMS) then
        if player:delItem(xi.item.CHUNK_OF_ORICHALCUM_ORE, 1, xi.inv.TEMPITEMS) then
            player:messageSpecial(ID.text.YOU_FOUND_SOME, 0)

            player:timer(3000, function()
                if player:getInstance() then
                    player:messageSpecial(ID.text.AMAZING_LOOK_AT_IT, xi.item.CHUNK_OF_ORICHALCUM_ORE)

                    player:timer(2000, function()
                        if player:getInstance() then
                            player:messageSpecial(ID.text.THE_RUMORS_WERE_TRUE, 0)

                            player:timer(5000, function()
                                if instance:getProgress() < 1 then
                                    instance:setProgress(1)
                                end
                            end)
                        end
                    end)
                end
            end)

            return
        end
    end

    player:messageSpecial(ID.text.BRING_ORICHALCUM_ORE_BACK, xi.item.CHUNK_OF_ORICHALCUM_ORE)

    if player:hasItem(xi.item.PICKAXE, xi.inv.TEMPITEMS) then
        player:messageSpecial(ID.text.ALREADY_HAVE_PICKAXE, xi.item.PICKAXE)
        return
    else
        if player:addTempItem(xi.item.PICKAXE) then
            player:messageSpecial(ID.text.OBTAIN_PICKAXE, xi.item.PICKAXE)
        end
    end
end

return entity
