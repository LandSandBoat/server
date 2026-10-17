-----------------------------------
-- Gold World Pass dealers
-- https://www.bg-wiki.com/ffxi/Gold_World_Pass
-----------------------------------
xi = xi or {}
xi.worldPass = xi.worldPass or {}

local dealerEvents =
{
    [xi.zone.PORT_SAN_DORIA] = 710,
    [xi.zone.PORT_BASTOK   ] = 96,
    [xi.zone.HEAVENS_TOWER ] = 10000,
}

-----------------------------------
-- Purchase
-----------------------------------
local price    = 1000
local validFor = utils.days(7)

local para =
{
    BEGIN_PURCHASE        = 0,
    CONFIRM_PURCHASE      = 1,
    BEGIN_GOLD_PURCHASE   = 2,
    CONFIRM_GOLD_PURCHASE = 3,
}

-- the client reads the reply type differently before and after the Yes/No prompt
local replyType =
{
    UNAVAILABLE    = { begin = 0, confirm = 5 },
    ISSUED         = { begin = 1, confirm = 6 },
    NOT_ENOUGH_GIL = { begin = 2, confirm = 4 },
    CONFIRM_PRICE  = { begin = 3 },
}

local function issuedReply(pass, step)
    local leftNum = 0
    if step == 'confirm' then
        leftNum = 1
    end

    return
    {
        type      = replyType.ISSUED[step],
        leftNum   = leftNum,
        -- retail shows 167 hours on a pass issued that second
        leftHours = math.floor((pass.expiry - GetSystemTime() - 1) / 3600),
        price     = price,
        code      = string.format('%010d', pass.code),
    }
end

-----------------------------------
-- Benefits
-----------------------------------
local maxInvites    = 15
local milestoneDays = { [0] = 0, 40, 70, 100, 365 }

local role =
{
    INVITER = 1,
    INVITEE = 2,
}

-- event param 0 of the "Gold World Pass benefits" branch
local benefitState =
{
    NOT_PAIRED           = 0,
    FIRST_DAY_ITEMS      = 5,
    INVITEE_RECEIVED     = 100,
    INVITER_RECEIVED     = 101,
    FRIEND_FIRST         = 102,
    INVITER_ALL_RECEIVED = 103,
    INVITEE_ALL_RECEIVED = 104,
    INVITE_LIMIT         = 105,
    NOT_YET              = 110,
    INVITER_CHOICE       = 0,  -- + milestone
    INVITEE_CHOICE       = 10, -- + milestone
}

-- the inviter receives nothing on the first day
local roleStates =
{
    [role.INVITER] = { firstMilestone = 1, choice = benefitState.INVITER_CHOICE, received = benefitState.INVITER_RECEIVED, allReceived = benefitState.INVITER_ALL_RECEIVED },
    [role.INVITEE] = { firstMilestone = 0, choice = benefitState.INVITEE_CHOICE, received = benefitState.INVITEE_RECEIVED, allReceived = benefitState.INVITEE_ALL_RECEIVED },
}

-- unverified: an owned echad ring is skipped, the vouchers are still given
local function getFirstDayItems(player)
    local items = { { xi.item.COPPER_AMAN_VOUCHER, 12 } }
    if not player:hasItem(xi.item.ECHAD_RING) then
        table.insert(items, xi.item.ECHAD_RING)
    end

    return items
end

-- main menu items, with who can pick them and from which milestone
local menuItems =
{
    [1] = { item = xi.item.GUIDE_BERET,       role = role.INVITER, milestone = 1 },
    [2] = { item = xi.item.SPROUT_BERET,      role = role.INVITEE, milestone = 1 },
    [3] = { item = xi.item.MANDRAGORA_BERET,  role = role.INVITER, milestone = 1 },
    [4] = { item = xi.item.DETONATOR_BELT,                         milestone = 2 },
    [5] = { item = xi.item.TIMEPIECE,                              milestone = 3 },
    [6] = { item = xi.item.MINIATURE_AIRSHIP,                      milestone = 4 },
    [7] = { item = xi.item.GOLD_MOOGLE_BELT,  role = role.INVITER, milestone = 4 },
}

local swimsuits =
{
    [xi.race.HUME_M  ] = { { xi.item.HUME_GILET,       xi.item.HUME_TRUNKS     }, { xi.item.HUME_GILET_P1,       xi.item.HUME_TRUNKS_P1     } },
    [xi.race.HUME_F  ] = { { xi.item.HUME_TOP,         xi.item.HUME_SHORTS     }, { xi.item.HUME_TOP_P1,         xi.item.HUME_SHORTS_P1     } },
    [xi.race.ELVAAN_M] = { { xi.item.ELVAAN_GILET,     xi.item.ELVAAN_TRUNKS   }, { xi.item.ELVAAN_GILET_P1,     xi.item.ELVAAN_TRUNKS_P1   } },
    [xi.race.ELVAAN_F] = { { xi.item.ELVAAN_TOP,       xi.item.ELVAAN_SHORTS   }, { xi.item.ELVAAN_TOP_P1,       xi.item.ELVAAN_SHORTS_P1   } },
    [xi.race.TARU_M  ] = { { xi.item.TARUTARU_MAILLOT, xi.item.TARUTARU_TRUNKS }, { xi.item.TARUTARU_MAILLOT_P1, xi.item.TARUTARU_TRUNKS_P1 } },
    [xi.race.TARU_F  ] = { { xi.item.TARUTARU_TOP,     xi.item.TARUTARU_SHORTS }, { xi.item.TARUTARU_TOP_P1,     xi.item.TARUTARU_SHORTS_P1 } },
    [xi.race.MITHRA  ] = { { xi.item.MITHRA_TOP,       xi.item.MITHRA_SHORTS   }, { xi.item.MITHRA_TOP_P1,       xi.item.MITHRA_SHORTS_P1   } },
    [xi.race.GALKA   ] = { { xi.item.GALKA_GILET,      xi.item.GALKA_TRUNKS    }, { xi.item.GALKA_GILET_P1,      xi.item.GALKA_TRUNKS_P1    } },
}

-- indexed by gender + 1
local yukatas =
{
    { xi.item.OMINA_YUKATA, xi.item.ONOKO_YUKATA },
    { xi.item.LADYS_YUKATA, xi.item.LORDS_YUKATA },
}

local cityItems =
{
    [xi.zone.PORT_SAN_DORIA] = { xi.item.RABBIT_BELT,     xi.item.KINGDOM_STABLES_COLLAR   },
    [xi.zone.PORT_BASTOK   ] = { xi.item.WORM_BELT,       xi.item.REPUBLIC_STABLES_MEDAL   },
    [xi.zone.HEAVENS_TOWER ] = { xi.item.MANDRAGORA_BELT, xi.item.FEDERATION_STABLES_SCARF },
}

local function swimsuit(list, piece)
    return function(player)
        return swimsuits[player:getRace()][list][piece]
    end
end

local function yukata(list)
    return function(player)
        return yukatas[list][player:getGender() + 1]
    end
end

local function cityItem(list)
    return function(player)
        return cityItems[player:getZoneID()][list]
    end
end

-- menu options 1 to 7 give an item, 8 and 9 open the item lists whose picks come back as offset + n
local listOneOption = 8
local listTwoOption = 9

-- indexed by the position the event sends back; list II has no item at 1 or 16
local itemLists =
{
    [listOneOption] =
    {
        offset    = 32,
        milestone = { [role.INVITER] = 1, [role.INVITEE] = 1 },
        items     =
        {
            { xi.item.COPPER_AMAN_VOUCHER, 12 },
            xi.item.BRONZE_MOOGLE_BELT,
            xi.item.PUMPKIN_HEAD,
            xi.item.TRICK_STAFF,
            yukata(1),
            xi.item.DREAM_HAT,
            cityItem(1),
            xi.item.WOODEN_KATANA,
            swimsuit(1, 1),
            swimsuit(1, 2),
            xi.item.PITCHFORK,
            xi.item.DREAM_ROBE,
            xi.item.CHARM_WAND,
            xi.item.LUNAR_CAP,
            xi.item.DREAM_BOOTS,
            xi.item.EGG_HELM,
            xi.item.MIRACLE_WAND,
            xi.item.IBUSHI_SHINAI,
            xi.item.GREEN_MOG_PELL,
            xi.item.BOWL_OF_GOBLIN_STEW_880,
            xi.item.TRIZEK_RING,
        },
    },

    [listTwoOption] =
    {
        offset    = 64,
        milestone = { [role.INVITER] = 2, [role.INVITEE] = 3 },
        items     =
        {
            [2]  = xi.item.SILVER_MOOGLE_BELT,
            [3]  = xi.item.HORROR_HEAD,
            [4]  = xi.item.TREAT_STAFF,
            [5]  = yukata(2),
            [6]  = xi.item.DREAM_HAT_P1,
            [7]  = cityItem(2),
            [8]  = xi.item.HARDWOOD_KATANA,
            [9]  = swimsuit(2, 1),
            [10] = swimsuit(2, 2),
            [11] = xi.item.PITCHFORK_P1,
            [12] = xi.item.DREAM_ROBE_P1,
            [13] = xi.item.CHARM_WAND_P1,
            [14] = xi.item.SOL_CAP,
            [15] = xi.item.DREAM_BOOTS_P1,
            [17] = xi.item.MIRACLE_WAND_P1,
            [18] = xi.item.IBUSHI_SHINAI_P1,
            [19] = xi.item.RED_MOG_PELL,
            [20] = xi.item.MOG_KUPON_W_JOB,
            [21] = xi.item.MOG_KUPON_I_AF109,
            [22] = xi.item.ASTRAL_CUBE,
            [23] = xi.item.LEAF_BENCH,
        },
    },
}

local function isMenuOptionAvailable(option, partyRole, milestone)
    local entry = menuItems[option]
    if entry then
        return milestone >= entry.milestone and
            (entry.role == nil or entry.role == partyRole)
    end

    local list = itemLists[option]

    return list ~= nil and milestone >= list.milestone[partyRole]
end

-- the event hides every main menu option whose bit is set
local function getMenuMask(partyRole, milestone)
    local mask = 0
    for option = 1, listTwoOption do
        if not isMenuOptionAvailable(option, partyRole, milestone) then
            mask = utils.mask.setBit(mask, option, true)
        end
    end

    return mask
end

-- the event returns the menu option, or the list offset + the position in that list
local function getChosenItem(player, benefit, choice)
    local option = choice
    if choice > itemLists[listTwoOption].offset then
        option = listTwoOption
    elseif choice > itemLists[listOneOption].offset then
        option = listOneOption
    end

    if not isMenuOptionAvailable(option, benefit.pair.role, benefit.milestone) then
        return nil
    end

    local list = itemLists[option]
    if not list then
        return menuItems[option].item
    end

    local item = list.items[choice - list.offset]
    if type(item) == 'function' then
        return item(player)
    end

    return item
end

-- the invitee and inviter must be the only two members of the party, in the same zone
local function getPair(player)
    if player:getPartySize() ~= 2 then
        return nil
    end

    for _, member in pairs(player:getParty()) do
        if
            member:getID() ~= player:getID() and
            member:isPC() and
            member:getZoneID() == player:getZoneID()
        then
            local invite = GetWorldPassInvite(player:getID(), member:getID())
            if invite then
                return { inviteeId = member:getID(), role = role.INVITER, invite = invite }
            end

            invite = GetWorldPassInvite(member:getID(), player:getID())
            if invite then
                return { inviteeId = player:getID(), role = role.INVITEE, invite = invite }
            end
        end
    end

    return nil
end

-- nothing to pick right now: say when to come back, or that everything was received
-- the inviter is told how many people it accompanied, the invitee only about this pairing
local function getWaitingBenefit(player, partyRole, claims, daysSinceJoined)
    local states  = roleStates[partyRole]
    local invites = nil
    if partyRole == role.INVITER then
        invites = CountWorldPassInvites(player:getID())
    end

    local lastClaimed = nil
    for milestone = 0, #milestoneDays do
        if utils.mask.getBit(claims, milestone) then
            lastClaimed = milestone
        end
    end

    for milestone = 0, #milestoneDays do
        if milestoneDays[milestone] > daysSinceJoined then
            local daysLeft = milestoneDays[milestone] - daysSinceJoined
            if not lastClaimed then
                return { state = benefitState.NOT_YET, daysLeft = daysLeft }
            end

            return { state = states.received, milestone = lastClaimed, daysLeft = daysLeft, invites = invites }
        end
    end

    return { state = states.allReceived, milestone = #milestoneDays, invites = invites }
end

local function getBenefit(player)
    local pair = getPair(player)
    if not pair then
        return { state = benefitState.NOT_PAIRED }
    end

    local daysSinceJoined = math.floor((GetSystemTime() - pair.invite.joined) / utils.days(1))
    local states          = roleStates[pair.role]
    local inviteeClaims   = pair.invite.inviteeClaims
    local claims          = inviteeClaims
    if pair.role == role.INVITER then
        claims = pair.invite.inviterClaims
    end

    for milestone = states.firstMilestone, #milestoneDays do
        if
            milestoneDays[milestone] <= daysSinceJoined and
            not utils.mask.getBit(claims, milestone)
        then
            if milestone == 0 then
                return { state = benefitState.FIRST_DAY_ITEMS, milestone = 0, pair = pair }
            end

            if pair.role == role.INVITER then
                if not utils.mask.getBit(inviteeClaims, milestone) then
                    return { state = benefitState.FRIEND_FIRST }
                end

                if
                    claims == 0 and
                    CountWorldPassInvites(player:getID()) >= maxInvites
                then
                    return { state = benefitState.INVITE_LIMIT, milestone = milestone, invites = maxInvites }
                end
            end

            return
            {
                state     = states.choice + milestone,
                milestone = milestone,
                menuMask  = getMenuMask(pair.role, milestone),
                pair      = pair,
            }
        end
    end

    return getWaitingBenefit(player, pair.role, claims, daysSinceJoined)
end

-- states the event finishes with when an item was picked
local function isPickState(state)
    return state == benefitState.FIRST_DAY_ITEMS or
        (state > benefitState.INVITER_CHOICE and state <= benefitState.INVITER_CHOICE + #milestoneDays) or
        (state > benefitState.INVITEE_CHOICE and state <= benefitState.INVITEE_CHOICE + #milestoneDays)
end

-----------------------------------
-- Dealer entry points
-----------------------------------
xi.worldPass.onTrigger = function(player, npc)
    local benefit = getBenefit(player)

    player:startEvent(dealerEvents[player:getZoneID()],
        benefit.state,
        benefit.daysLeft or 0,
        benefit.invites or 0,
        0,
        benefit.milestone or 0,
        benefit.menuMask or -1,
        2, -- gold pass only
        0)
end

-- the option carries the benefit state in the upper 16 bits and the picked item in the lower 16
xi.worldPass.onEventFinish = function(player, csid, option, npc)
    if csid ~= dealerEvents[player:getZoneID()] then
        return
    end

    local requestedState = bit.rshift(option, 16)
    if not isPickState(requestedState) then
        return
    end

    local benefit = getBenefit(player)
    if benefit.state ~= requestedState then
        player:messageSpecial(zones[player:getZoneID()].text.WORLD_PASS_PARTY_CHANGED)
        return
    end

    local items = nil
    if benefit.state == benefitState.FIRST_DAY_ITEMS then
        items = getFirstDayItems(player)
    else
        local item = getChosenItem(player, benefit, bit.band(option, 0xFFFF))
        if not item then
            return
        end

        items = { item }
    end

    if not npcUtil.giveItem(player, items) then
        return
    end

    local invite = benefit.pair.invite
    if benefit.pair.role == role.INVITEE then
        invite.inviteeClaims = utils.mask.setBit(invite.inviteeClaims, benefit.milestone, true)
    else
        invite.inviterClaims = utils.mask.setBit(invite.inviterClaims, benefit.milestone, true)
    end

    SetWorldPassClaims(benefit.pair.inviteeId, invite.inviteeClaims, invite.inviterClaims)
end

xi.worldPass.onRequest = function(player, requestPara, eventId)
    local step = 'begin'
    if
        requestPara == para.CONFIRM_PURCHASE or
        requestPara == para.CONFIRM_GOLD_PURCHASE
    then
        step = 'confirm'
    end

    if
        dealerEvents[player:getZoneID()] ~= eventId or
        requestPara == para.BEGIN_PURCHASE or
        requestPara == para.CONFIRM_PURCHASE
    then
        return { type = replyType.UNAVAILABLE[step] }
    end

    -- one pass per week: an active pass is shown again instead of issuing a new one
    local pass = GetActiveWorldPass(player:getID())
    if pass then
        return issuedReply(pass, step)
    end

    if player:getGil() < price then
        return { type = replyType.NOT_ENOUGH_GIL[step], price = price }
    end

    if step == 'begin' then
        return { type = replyType.CONFIRM_PRICE.begin, price = price }
    end

    local expiry = GetSystemTime() + validFor
    local code   = IssueWorldPass(player:getID(), expiry)
    if code == 0 then
        return { type = replyType.UNAVAILABLE.confirm }
    end

    player:delGil(price)

    return issuedReply({ code = code, expiry = expiry }, step)
end
