-----------------------------------
-- Area: Port Bastok
--  NPC: Nokkhi Jinjahl
-- Type: Travelling Merchant NPC / NPC Quiver Maker / Bastok 1st Place
-- !pos 111 8 -47 236
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local bundleList =
    {
        { xi.item.ACHIYALABOPA_ARROW,  xi.item.ACHIYALABOPA_QUIVER       },
        { xi.item.ADLIVUN_ARROW,       xi.item.ADLIVUN_QUIVER            },
        { xi.item.ANTLION_ARROW,       xi.item.ANTLION_QUIVER            },
        { xi.item.BEETLE_ARROW,        xi.item.BEETLE_QUIVER             },
        { xi.item.CHAPULI_ARROW,       xi.item.CHAPULI_QUIVER            },
        { xi.item.DEMON_ARROW,         xi.item.DEMON_QUIVER              },
        { xi.item.EMINENT_ARROW,       xi.item.EMINENT_QUIVER            },
        { xi.item.GARGOUILLE_ARROW,    xi.item.GARGOUILLE_QUIVER         },
        { xi.item.HORN_ARROW,          xi.item.HORN_QUIVER               },
        { xi.item.IRON_ARROW,          xi.item.IRON_QUIVER               },
        { xi.item.KABURA_ARROW,        xi.item.KABURA_QUIVER             },
        { xi.item.MANTID_ARROW,        xi.item.MANTID_QUIVER             },
        { xi.item.RAKAZNAR_ARROW,      xi.item.RAKAZNAR_QUIVER           },
        { xi.item.RAAZ_ARROW,          xi.item.RAAZ_QUIVER               },
        { xi.item.RUSZOR_ARROW,        xi.item.RUSZOR_QUIVER             },
        { xi.item.SCORPION_ARROW,      xi.item.SCORPION_QUIVER           },
        { xi.item.SILVER_ARROW,        xi.item.SILVER_QUIVER             },
        { xi.item.SLEEP_ARROW,         xi.item.SLEEP_QUIVER              },
        { xi.item.STONE_ARROW,         xi.item.STONE_QUIVER              },
        { xi.item.TULFAIRE_ARROW,      xi.item.TULFAIRE_QUIVER           },

        { xi.item.ABRASION_BOLT,       xi.item.ABRASION_BOLT_QUIVER      },
        { xi.item.ACHIYALABOPA_BOLT,   xi.item.ACHIYALABOPA_BOLT_QUIVER  },
        { xi.item.ACID_BOLT,           xi.item.ACID_BOLT_QUIVER          },
        { xi.item.ADAMAN_BOLT,         xi.item.ADAMAN_BOLT_QUIVER        },
        { xi.item.ADLIVUN_BOLT,        xi.item.ADLIVUN_BOLT_QUIVER       },
        { xi.item.BISMUTH_BOLT,        xi.item.BISMUTH_BOLT_QUIVER       },
        { xi.item.BLIND_BOLT,          xi.item.BLIND_BOLT_QUIVER         },
        { xi.item.BLOODY_BOLT,         xi.item.BLOODY_BOLT_QUIVER        },
        { xi.item.DAMASCUS_BOLT,       xi.item.DAMASCUS_BOLT_QUIVER      },
        { xi.item.DARK_ADAMAN_BOLT,    xi.item.DARK_ADAMAN_BOLT_QUIVER   },
        { xi.item.DARKLING_BOLT,       xi.item.DARKLING_BOLT_QUIVER      },
        { xi.item.DARKSTEEL_BOLT,      xi.item.DARKSTEEL_BOLT_QUIVER     },
        { xi.item.EMINENT_BOLT,        xi.item.EMINENT_BOLT_QUIVER       },
        { xi.item.FUSION_BOLT,         xi.item.FUSION_BOLT_QUIVER        },
        { xi.item.GASHING_BOLT,        xi.item.GASHING_BOLT_QUIVER       },
        { xi.item.HOLY_BOLT,           xi.item.HOLY_BOLT_QUIVER          },
        { xi.item.MIDRIUM_BOLT,        xi.item.MIDRIUM_BOLT_QUIVER       },
        { xi.item.MYTHRIL_BOLT,        xi.item.MYTHRIL_BOLT_QUIVER       },
        { xi.item.OXIDANT_BOLT,        xi.item.OXIDANT_BOLT_QUIVER       },
        { xi.item.RAKAZNAR_BOLT,       xi.item.RAKAZNAR_BOLT_QUIVER      },
        { xi.item.RIGHTEOUS_BOLT,      xi.item.RIGHTEOUS_BOLT_QUIVER     },
        { xi.item.SLEEP_BOLT,          xi.item.SLEEP_BOLT_QUIVER         },
        { xi.item.TITANIUM_BOLT,       xi.item.TITANIUM_BOLT_QUIVER      },
        { xi.item.VENOM_BOLT,          xi.item.VENOM_BOLT_QUIVER         },

        { xi.item.ADAMAN_BULLET,       xi.item.ADAMAN_BULLET_POUCH       },
        { xi.item.ADLIVUN_BULLET,      xi.item.ADLIVUN_BULLET_POUCH      },
        { xi.item.ACHIYALABOPA_BULLET, xi.item.ACHIYALABOPA_BULLET_POUCH },
        { xi.item.BULLET,              xi.item.BULLET_POUCH              },
        { xi.item.BISMUTH_BULLET,      xi.item.BISMUTH_BULLET_POUCH      },
        { xi.item.BRONZE_BULLET,       xi.item.BRONZE_BULLET_POUCH       },
        { xi.item.DAMASCUS_BULLET,     xi.item.DAMASCUS_BULLET_POUCH     },
        { xi.item.DARK_ADAMAN_BULLET,  xi.item.DARK_ADAMAN_BULLET_POUCH  },
        { xi.item.DECIMATING_BULLET,   xi.item.DECIMATING_BULLET_POUCH   },
        { xi.item.DIVINE_BULLET,       xi.item.DIVINE_BULLET_POUCH       },
        { xi.item.DWEOMER_BULLET,      xi.item.DWEOMER_BULLET_POUCH      },
        { xi.item.EMINENT_BULLET,      xi.item.EMINENT_BULLET_POUCH      },
        { xi.item.IRON_BULLET,         xi.item.IRON_BULLET_POUCH         },
        { xi.item.ORICHALCUM_BULLET,   xi.item.ORICHALCUM_BULLET_POUCH   },
        { xi.item.OBERON_BULLET,       xi.item.OBERON_BULLET_POUCH       },
        { xi.item.RAKAZNAR_BULLET,     xi.item.RAKAZNAR_BULLET_POUCH     },
        { xi.item.SILVER_BULLET,       xi.item.SILVER_BULLET_POUCH       },
        { xi.item.STEEL_BULLET,        xi.item.STEEL_BULLET_POUCH        },
        { xi.item.SPARTAN_BULLET,      xi.item.SPARTAN_BULLET_POUCH      },
        { xi.item.TITANIUM_BULLET,     xi.item.TITANIUM_BULLET_POUCH     },

        { xi.item.FIRE_CARD,           xi.item.FIRE_CARD_CASE            },
        { xi.item.ICE_CARD,            xi.item.ICE_CARD_CASE             },
        { xi.item.WIND_CARD,           xi.item.WIND_CARD_CASE            },
        { xi.item.EARTH_CARD,          xi.item.EARTH_CARD_CASE           },
        { xi.item.THUNDER_CARD,        xi.item.THUNDER_CARD_CASE         },
        { xi.item.WATER_CARD,          xi.item.WATER_CARD_CASE           },
        { xi.item.LIGHT_CARD,          xi.item.LIGHT_CARD_CASE           },
        { xi.item.DARK_CARD,           xi.item.DARK_CARD_CASE            },
    }

    local carnationsNeeded = 0
    local giveToPlayer = {}

    -- check for invalid items
    for i = 0, 8, 1 do
        local itemId = trade:getItemId(i)
        if itemId > 0 and itemId ~= 948 then
            local validSlot = false
            for k, v in pairs(bundleList) do
                if v[1] == itemId then
                    local itemQty = trade:getSlotQty(i)
                    if itemQty % 99 ~= 0 then
                        player:messageSpecial(ID.text.NOKKHI_BAD_COUNT)
                        return
                    end

                    local stacks = itemQty / 99
                    carnationsNeeded = carnationsNeeded + stacks
                    giveToPlayer[#giveToPlayer + 1] = { v[2], stacks }
                    validSlot = true
                    break
                end
            end

            if not validSlot then
                player:messageSpecial(ID.text.NOKKHI_BAD_ITEM)
                return
            end
        end
    end

    -- check for correct number of carnations
    if
        carnationsNeeded == 0 or
        trade:getItemQty(xi.item.CARNATION) ~= carnationsNeeded
    then
        player:messageSpecial(ID.text.NOKKHI_BAD_COUNT)
        return
    end

    -- check for enough inventory space
    if player:getFreeSlotsCount() < carnationsNeeded then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, giveToPlayer[1][1])
        return
    end

    -- make the trade
    player:messageSpecial(ID.text.NOKKHI_GOOD_TRADE)
    for k, v in pairs(giveToPlayer) do
        player:addItem(v[1], v[2])
        player:messageSpecial(ID.text.ITEM_OBTAINED, v[1])
    end

    player:tradeComplete()
end

entity.onTrigger = function(player, npc)
    player:startEvent(285, npc:getID())
end

return entity
