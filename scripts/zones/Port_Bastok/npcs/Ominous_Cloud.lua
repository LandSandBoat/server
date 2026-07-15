-----------------------------------
-- Area: Port Bastok
--  NPC: Ominous Cloud
-- Type: Ninjutsu Toolbag Maker
-- !pos 146.962 7.499 -63.316 236
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local toolList =
    {
        { xi.item.UCHITAKE,           xi.item.TOOLBAG_UCHITAKE         },
        { xi.item.TSURARA,            xi.item.TOOLBAG_TSURARA          },
        { xi.item.KAWAHORI_OGI,       xi.item.TOOLBAG_KAWAHORI_OGI     },
        { xi.item.MAKIBISHI,          xi.item.TOOLBAG_MAKIBISHI        },
        { xi.item.HIRAISHIN,          xi.item.TOOLBAG_HIRAISHIN        },
        { xi.item.MIZU_DEPPO,         xi.item.TOOLBAG_MIZU_DEPPO       },
        { xi.item.SHIHEI,             xi.item.TOOLBAG_SHIHEI           },
        { xi.item.JUSATSU,            xi.item.TOOLBAG_JUSATSU          },
        { xi.item.KAGINAWA,           xi.item.TOOLBAG_KAGINAWA         },
        { xi.item.SAIRUI_RAN,         xi.item.TOOLBAG_SAIRUI_RAN       },
        { xi.item.KODOKU,             xi.item.TOOLBAG_KODOKU           },
        { xi.item.SHINOBI_TABI,       xi.item.TOOLBAG_SHINOBI_TABI     },
        { xi.item.SANJAKU_TENUGUI,    xi.item.TOOLBAG_SANJAKU_TENUGUI  },
        { xi.item.SOSHI,              xi.item.TOOLBAG_SOSHI            },
        { xi.item.KABENRO,            xi.item.TOOLBAG_KABENRO          },
        { xi.item.JINKO,              xi.item.TOOLBAG_JINKO            },
        { xi.item.MOKUJIN,            xi.item.TOOLBAG_MOKUJIN          },
        { xi.item.INOSHISHINOFUDA,    xi.item.TOOLBAG_INOSHISHINOFUDA  },
        { xi.item.SHIKANOFUDA,        xi.item.TOOLBAG_SHIKANOFUDA      },
        { xi.item.CHONOFUDA,          xi.item.TOOLBAG_CHONOFUDA        },

        { xi.item.SHURIKEN,           xi.item.SHURIKEN_POUCH           },
        { xi.item.JUJI_SHURIKEN,      xi.item.JUJI_SHURIKEN_POUCH      },
        { xi.item.MANJI_SHURIKEN,     xi.item.MANJI_SHURIKEN_POUCH     },
        { xi.item.FUMA_SHURIKEN,      xi.item.FUMA_SHURIKEN_POUCH      },
        { xi.item.KOGA_SHURIKEN,      xi.item.KOGA_SHURIKEN_POUCH      },
        { xi.item.IGA_SHURIKEN,       xi.item.IGA_SHURIKEN_POUCH       },
        { xi.item.ROPPO_SHURIKEN,     xi.item.ROPPO_SHURIKEN_POUCH     },
        { xi.item.ROPPO_SHURIKEN_P1,  xi.item.ROPPO_SHURIKEN_P1_POUCH  },
        { xi.item.HAPPO_SHURIKEN,     xi.item.HAPPO_SHURIKEN_POUCH     },
        { xi.item.HAPPO_SHURIKEN_P1,  xi.item.HAPPO_SHURIKEN_P1_POUCH  },
        { xi.item.HACHIYA_SHURIKEN,   xi.item.HACHIYA_SHURIKEN_POUCH   },
        { xi.item.SUPPA_SHURIKEN,     xi.item.SUPPA_SHURIKEN_POUCH     },
        { xi.item.TOGAKUSHI_SHURIKEN, xi.item.TOGAKUSHI_SHURIKEN_POUCH },
        { xi.item.SASUKE_SHURIKEN,    xi.item.SASUKE_SHURIKEN_POUCH    },
        { xi.item.SASUKE_SHURIKEN_P1, xi.item.SASUKE_SHURIKEN_POUCH_P1 },
    }

    local fruitNeeded = 0
    local giveToPlayer = {}

    -- check for invalid items
    for i = 0, 8, 1 do
        local itemId = trade:getItemId(i)
        if itemId > 0 and itemId ~= xi.item.WIJNRUIT then
            local validSlot = false
            for k, v in pairs(toolList) do
                if v[1] == itemId then
                    local itemQty = trade:getSlotQty(i)
                    if itemQty % 99 ~= 0 then
                        player:messageSpecial(ID.text.CLOUD_BAD_COUNT, xi.item.WIJNRUIT)
                        return
                    end

                    local stacks = itemQty / 99
                    fruitNeeded = fruitNeeded + stacks
                    giveToPlayer[#giveToPlayer + 1] = { v[2], stacks }
                    validSlot = true
                    break
                end
            end

            if not validSlot then
                player:messageSpecial(ID.text.CLOUD_BAD_ITEM)
                return
            end
        end
    end

    -- check for correct number of wijnfruit
    if fruitNeeded == 0 or trade:getItemQty(xi.item.WIJNRUIT) ~= fruitNeeded then
        player:messageSpecial(ID.text.CLOUD_BAD_COUNT, xi.item.WIJNRUIT)
        return
    end

    -- check for enough inventory space
    if player:getFreeSlotsCount() < fruitNeeded then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, giveToPlayer[1][1])
        return
    end

    -- make the trade
    player:messageSpecial(ID.text.CLOUD_GOOD_TRADE)
    for k, v in pairs(giveToPlayer) do
        player:addItem(v[1], v[2])
        player:messageSpecial(ID.text.ITEM_OBTAINED, v[1])
    end

    player:tradeComplete()
end

entity.onTrigger = function(player, npc)
    player:startEvent(345, npc:getID())
end

return entity
