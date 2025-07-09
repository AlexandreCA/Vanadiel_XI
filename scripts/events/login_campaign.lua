-----------------------------------
-- Login Campaign
-- https://www.bg-wiki.com/ffxi/Repeat_Login_Campaign
-----------------------------------
require('scripts/globals/npc_util')
local prizes = require('scripts/events/login_campaign_data')
-----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.loginCampaign = xi.events.loginCampaign or {}

-- Auto-generates campaign dates each month (ALL TIMES JST)
local function getCurrentCampaignDates()
    local year = JstYear()
    local month = JstMonth()
    local day = JstDayOfTheMonth()
    local hour = JstHour()

    if day < 11 or (day == 11 and hour < 17) then
        month = month - 1
        if month < 1 then
            month = 12
            year = year - 1
        end
    end

    local start = { year = year, month = month, day = 11, hour = 17 }

    local endMonth = month + 1
    local endYear = year
    if endMonth > 12 then
        endMonth = 1
        endYear = year + 1
    end

    local loginEnd = { year = endYear, month = endMonth, day = 2, hour = 23 }
    local redeemEnd = { year = endYear, month = endMonth, day = 10, hour = 0 }

    return start, loginEnd, redeemEnd
end

local loginCampaignStart, loginCampaignEnd, loginCampaignRedeem = getCurrentCampaignDates()

-- Checks if a Login Campaign is active.
xi.events.loginCampaign.canEarnPoints = function()
    if xi.settings.main.ENABLE_LOGIN_CAMPAIGN == 1 then
        local jstNow = { year = JstYear(), month = JstMonth(), day = JstDayOfTheMonth(), hour = JstHour() }
        return utils.timeIsAfterOrEqual(jstNow, loginCampaignStart) and
            utils.timeIsBefore(jstNow, loginCampaignEnd)
    end
end

xi.events.loginCampaign.canExchangePoints = function()
    if xi.settings.main.ENABLE_LOGIN_CAMPAIGN == 1 then
        local jstNow = { year = JstYear(), month = JstMonth(), day = JstDayOfTheMonth(), hour = JstHour() }
        return utils.timeIsAfterOrEqual(jstNow, loginCampaignStart) and
            utils.timeIsBefore(jstNow, loginCampaignRedeem)
    end
end

-- Gives Login Points once a day.
xi.events.loginCampaign.onGameIn = function(player)
    if not xi.events.loginCampaign.canEarnPoints() then
        return
    end

    local zoneId      = player:getZoneID()
    local ID          = zones[zoneId]
    local loginPoints = player:getCurrency('login_points')

    local playercMonth = player:getCharVar('LoginCampaignMonth')
    local playercYear  = player:getCharVar('LoginCampaignYear')
    local nextMidnight = player:getCharVar('LoginCampaignNextMidnight')
    local loginCount   = player:getCharVar('LoginCampaignLoginNumber')

    if
        playercMonth ~= loginCampaignStart.month or
        playercYear ~= loginCampaignStart.year
    then
        if loginPoints > 1500 then
            player:setCurrency('login_points', 1500)
            player:messageSpecial(ID.text.CARRIED_OVER_POINTS, 0, 1500)
        elseif loginPoints ~= 0 then
            player:messageSpecial(ID.text.CARRIED_OVER_POINTS, 0, loginPoints)
        end

        player:setCharVar('LoginCampaignMonth', loginCampaignStart.month)
        player:setCharVar('LoginCampaignYear', loginCampaignStart.year)
        loginCount = 0
    end

    if nextMidnight ~= getMidnight() then
        player:messageSpecial(ID.text.LOGIN_CAMPAIGN_UNDERWAY, loginCampaignStart.year, loginCampaignStart.month)

        loginCount = loginCount + 1
        player:setCharVar('LoginCampaignNextMidnight', getMidnight())

        if loginCount == 1 then
            player:addCurrency('login_points', 500)
            player:messageSpecial(ID.text.LOGIN_NUMBER, 0, loginCount, 500, player:getCurrency('login_points'))
        else
            player:addCurrency('login_points', 100)
            player:messageSpecial(ID.text.LOGIN_NUMBER, 0, loginCount, 100, player:getCurrency('login_points'))
        end

        player:setCharVar('LoginCampaignLoginNumber', loginCount)
    end
end

-- Beginning of CS with Greeter Moogle.
xi.events.loginCampaign.onTrigger = function(player, csid)
    if not xi.events.loginCampaign.canExchangePoints() then
        return
    end

    local loginPoints = player:getCurrency('login_points')
    local cDate = bit.bor(loginCampaignStart.year, bit.lshift(loginCampaignStart.month, 28))
    local currentLoginCampaign = prizes
    local price = {}
    local priceShift = {}
    local hideOptions = 0

    for k, v in pairs(currentLoginCampaign) do
        price[k] = currentLoginCampaign[k]['price']
    end

    priceShift[1] = price[1] or 0
    priceShift[2] = bit.lshift(price[5] or 0, 16)
    priceShift[3] = price[9] or 0
    priceShift[4] = bit.lshift(price[13] or 0, 16)
    priceShift[5] = price[17] or 0
    priceShift[6] = bit.lshift(price[21] or 0, 16)
    priceShift[7] = price[25] or 0
    priceShift[8] = bit.lshift(price[29] or 0, 16)

    local priceBit1 = bit.bor(priceShift[1], priceShift[2])
    local priceBit2 = bit.bor(priceShift[3], priceShift[4])
    local priceBit3 = bit.bor(priceShift[5], priceShift[6])
    local priceBit4 = bit.bor(priceShift[7], priceShift[8])

    for i = 1, #priceShift do
        if priceShift[i] == 0 then
            hideOptions = bit.bor(hideOptions, bit.lshift(1, i - 1))
        end
    end

    player:startEvent(csid, cDate, loginPoints, priceBit1, priceBit2, priceBit3, priceBit4, hideOptions)
end

-- Show list of items / process purchase
xi.events.loginCampaign.onEventUpdate = function(player, csid, option, npc)
    if not xi.events.loginCampaign.canExchangePoints() then
        return
    end

    local showItems = bit.band(option, 31)
    local itemSelected = bit.band(bit.rshift(option, 5), 31)
    local itemQuantity = bit.band(bit.rshift(option, 11), 511)
    local currentLoginCampaign = prizes
    local loginPoints = player:getCurrency('login_points')

    if showItems % 4 == 1 then
        local items = {}
        for i = 1, 20 do
            table.insert(items, currentLoginCampaign[showItems]['items'][i] or 0)
        end
        player:updateEvent(
            bit.bor(items[1], bit.lshift(items[2], 16)),
            bit.bor(items[3], bit.lshift(items[4], 16)),
            bit.bor(items[5], bit.lshift(items[6], 16)),
            bit.bor(items[7], bit.lshift(items[8], 16)),
            bit.bor(items[9], bit.lshift(items[10], 16)),
            bit.bor(items[11], bit.lshift(items[12], 16)),
            bit.bor(items[13], bit.lshift(items[14], 16)),
            bit.bor(items[15], bit.lshift(items[16], 16)))
    elseif showItems % 4 == 2 then
        local price = currentLoginCampaign[showItems - 1]['price']
        local totalItemsMask = (2 ^ 20 - 1) - (2 ^ #currentLoginCampaign[showItems - 1]['items'] - 1)
        local items = {}

        for i = 1, 20 do
            table.insert(items, currentLoginCampaign[showItems - 1]['items'][i] or 0)
        end

        player:updateEvent(
            bit.bor(items[17], bit.lshift(items[18], 16)),
            bit.bor(items[19], bit.lshift(items[20], 16)),
            totalItemsMask,
            price,
            loginPoints)
    else
        if npcUtil.giveItem(player, { { currentLoginCampaign[showItems - 2]['items'][itemSelected + 1], itemQuantity } }) then
            player:delCurrency('login_points', currentLoginCampaign[showItems - 2]['price'] * itemQuantity)
            player:updateEvent(
                currentLoginCampaign[showItems - 2]['items'][itemSelected + 1],
                player:getCurrency('login_points'),
                0,
                currentLoginCampaign[showItems - 2]['price'],
                loginPoints)
        end
    end
end

-- Optional: GM command to display current campaign period
xi.events.loginCampaign.onCommand = function(player)
    if player:getGMLevel() >= 1 then
        player:PrintToPlayer(string.format("[LoginCampaign] Active from %04d-%02d-11 17:00 JST to %04d-%02d-02 23:00 JST",
            loginCampaignStart.year, loginCampaignStart.month, loginCampaignEnd.year, loginCampaignEnd.month))
        player:PrintToPlayer(string.format("[LoginCampaign] Redeem until %04d-%02d-10 00:00 JST",
            loginCampaignRedeem.year, loginCampaignRedeem.month))
    end
end
