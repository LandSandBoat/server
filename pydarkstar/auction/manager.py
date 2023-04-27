from ..tables.auctionhouse import AuctionHouse
from ..database import Database
from .worker import Worker
from .browser import Browser
from .cleaner import Cleaner
from .seller import Seller
from .buyer import Buyer
from .. import timeutils
import datetime
import random


class Manager(Worker):
    """
    Auction House browser.

    :param db: database object
    """

    def __init__(self, db, **kwargs):
        super(Manager, self).__init__(db, **kwargs)
        self.blacklist = set()
        self.browser = Browser(db, **kwargs)
        self.cleaner = Cleaner(db, **kwargs)
        self.seller = Seller(db, **kwargs)
        self.buyer = Buyer(db, **kwargs)

    @classmethod
    def create_database_and_manager(cls, hostname, database, username, password, name=None, fail=True):
        """
        Create database and manager at the same time.
        """
        # connect to database
        db = Database.pymysql(
            hostname=hostname,
            database=database,
            username=username,
            password=password,
        )

        # create auction house manager
        obj = cls(db, fail=fail)

        if name is not None:
            obj.seller.seller_name = name
            obj.buyer.buyer_name = name

        return obj

    def add_to_blacklist(self, rowid):
        """
        Add row to blacklist.
        """
        self.info('blacklisting: row=%d', rowid)
        self.blacklist.add(rowid)

    def buy_items(self, itemdata):
        """
        The main buy item loop.
        """
        with self.scopped_session(fail=self.fail) as session:
            # find rows that are still up for sale
            q = session.query(AuctionHouse).filter(
                AuctionHouse.seller != self.seller.seller,
                AuctionHouse.sell_date == 0,
                AuctionHouse.sale == 0,
            )
            # loop rows
            for row in q:
                with self.capture(fail=self.fail):
                    # skip blacklisted rows
                    if row.id not in self.blacklist:
                        # get item data
                        try:
                            data = itemdata[row.itemid]
                        except KeyError:
                            self.error('item missing from database: %d', row.itemid)
                            data = None

                        if data is not None:
                            # buy stacks
                            if row.stack:
                                # check permissions
                                if data.buy12:
                                    # check price
                                    if row.price <= data.price12:
                                        rand = (random.random())
                                        if rand <= 0.3:
                                            date = timeutils.timestamp(datetime.datetime.now())
                                            self.buyer.buy_item(row, date, data.price12)
                                    else:
                                        self.info('price too high! itemid=%d %d <= %d',
                                                  row.itemid, row.price, data.price12)
                                        self.add_to_blacklist(row.id)
                                else:
                                    self.debug('not allowed to buy item! itemid=%d', row.itemid)
                                    self.add_to_blacklist(row.id)
                            # buy singles
                            else:
                                # check permissions
                                if data.buy01:
                                    # check price
                                    if row.price <= data.price01:
                                        rand = (random.random())
                                        if rand <= 0.3:
                                            date = timeutils.timestamp(datetime.datetime.now())
                                            self.buyer.buy_item(row, date, data.price01)
                                    else:
                                        self.info('price too high! itemid=%d %d <= %d',
                                                  row.itemid, row.price, data.price01)
                                        self.add_to_blacklist(row.id)
                                else:
                                    self.debug('not allowed to buy item! itemid=%d', row.itemid)
                                    self.add_to_blacklist(row.id)
                        else:
                            # item data missing
                            self.add_to_blacklist(row.id)
                    else:
                        # row was blacklisted
                        self.debug('skipping row %d', row.id)

    def restock_items(self, itemdata):
        """
        The main restock loop.
        """
        # loop over items
        for data in itemdata.items.values():

            # singles
            if data.sell01:
                # check history
                history_price = self.browser.get_price(itemid=data.itemid, stack=False, seller=self.seller.seller)

                # set history
                if history_price is None or history_price <= 0:
                    now = timeutils.timestamp(datetime.datetime(2099, 1, 1))
                    self.seller.set_history(itemid=data.itemid, stack=False, price=data.price01, date=now, count=1)

                # get stock
                stock = self.browser.get_stock(itemid=data.itemid, stack=False, seller=self.seller.seller)

                # restock
                while stock < data.stock01:
                    now = timeutils.timestamp(datetime.datetime(2099, 1, 1))
                    self.seller.sell_item(itemid=data.itemid, stack=False, date=now, price=data.price01, count=1)
                    stock += 1

            # stacks
            if data.sell12:
                # check history
                history_price = self.browser.get_price(itemid=data.itemid, stack=True, seller=self.seller.seller)

                # set history
                if history_price is None or history_price <= 0:
                    now = timeutils.timestamp(datetime.datetime(2099, 1, 1))
                    self.seller.set_history(itemid=data.itemid, stack=True, price=data.price12, date=now, count=1)

                # get stock
                stock = self.browser.get_stock(itemid=data.itemid, stack=True, seller=self.seller.seller)

                # restock
                while stock < data.stock12:
                    now = timeutils.timestamp(datetime.datetime(2099, 1, 1))
                    self.seller.sell_item(itemid=data.itemid, stack=True, date=now, price=data.price12, count=1)
                    stock += 1


if __name__ == '__main__':
    pass
