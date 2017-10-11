#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import functools


class memoized(object):
    def __init__(self, func):
        self.func = func
        self.cache = {}

    def __call__(self, *args):
        try:
            return self.cache[args]
        except KeyError:
            value = self.func(*args)
            self.cache[args] = value
            return value
        except TypeError:
            # uncachable -- for instance, passing a list as an argument.
            # Better to not cache than to blow up entirely.
            return self.func(*args)

    def __repr__(self):
        '''Return the function's docstring.'''
        return self.func.__doc__

    def __get__(self, obj, objtype):
        '''Support instance methods.'''
        return functools.partial(self.__call__, obj)


def knapsack(items, maxweight):
    """
    Solve the knapsack problem by finding the most valuable
    subsequence of `items` subject that weighs no more than
    `maxweight`.

    `items` is a sequence of pairs `(value, weight)`, where `value` is
    a number and `weight` is a non-negative integer.

    `maxweight` is a non-negative integer.

    Return a pair whose first element is the sum of values in the most
    valuable subsequence, and whose second element is the subsequence.
    """

    # Return the value of the most valuable subsequence of the first i
    # elements in items whose weights sum to no more than j.
    @memoized
    def bestvalue(i, j):
        if i == 0: return 0
        value, weight, it = items[i - 1]
        if weight > j:
            return bestvalue(i - 1, j)
        else:
            return max(bestvalue(i - 1, j),
                       bestvalue(i - 1, j - weight) + value)

    j = maxweight
    result = []
    for i in xrange(len(items), 0, -1):
        if bestvalue(i, j) != bestvalue(i - 1, j):
            result.append(items[i - 1])
            j -= items[i - 1][1]
    result.reverse()
    return bestvalue(len(items), maxweight), result


_inventory_items = [
    {
        u'classid': u'395570628',
        u'instanceid': u'395564499',
        u'amount': 9.38,
        u'contextid': u'2',
        u'name': u'GenuineBladeofSoulHunger',
        u'appid': u'570',
        u'assetid': u'10948701076',
        u'sid': u'10948701076'
    },
    {
        u'classid': u'482037130',
        u'instanceid': u'519297549',
        u'amount': 8.62,
        u'contextid': u'2',
        u'name': u'GenuineLieutenantSquawkins',
        u'appid': u'570',
        u'assetid': u'10942957194',
        u'sid': u'10942957194'
    },
    {
        u'classid': u'2187822365',
        u'instanceid': u'2253222179',
        u'amount': 6.95,
        u'contextid': u'2',
        u'name': u"Inscribed Yulsaria's Glacier",
        u'appid': u'570',
        u'assetid': u'10991452890',
        u'sid': u'10991452890'
    },
    {
        u'classid': u'1399668417',
        u'instanceid': u'948149725',
        u'amount': 6.9,
        u'contextid': u'2',
        u'name': u'MantleoftheCinderBaron',
        u'appid': u'570',
        u'assetid': u'10942957173',
        u'sid': u'10942957173'
    },
    {
        u'classid': u'497876292',
        u'instanceid': u'497877347',
        u'amount': 5.49,
        u'contextid': u'2',
        u'name': u'InscribedTheLightningOrchid',
        u'appid': u'570',
        u'assetid': u'10942957110',
        u'sid': u'10942957110'
    },
    {
        u'classid': u'179233153',
        u'instanceid': u'0',
        u'amount': 5.26,
        u'contextid': u'2',
        u'name': u'Tinkbot',
        u'appid': u'570',
        u'assetid': u'10942957163',
        u'sid': u'10942957163'
    },
    {
        u'classid': u'497875795',
        u'instanceid': u'253033455',
        u'amount': 3.88,
        u'contextid': u'2',
        u'name': u"Inscribed Fin King's Charm",
        u'appid': u'570',
        u'assetid': u'10942386262',
        u'sid': u'10942386262'
    }
]


def do_test_items():
    items = [(i[u'amount'], i[u'amount'], i) for i in _inventory_items]
    maxweight = 9
    bestvalue, reconstruction = knapsack(items, maxweight)

    print('Best possible value: {0}'.format(bestvalue))
    print('Items:')
    for value, weight, it in reconstruction:
        print('V: {0}, W: {1}, I: {2}'.format(value, weight, it))


def do_knap():
    items = [(4, 12, 4), (2, 1, 2), (6, 4, 6), (1, 1, 1), (2, 2, 2)]
    maxweight = 15
    bestvalue, reconstruction = knapsack(items, maxweight)

    print('Best possible value: {0}'.format(bestvalue))
    print('Items:')
    for value, weight, it in reconstruction:
        print('V: {0}, W: {1}, I: {2}'.format(value, weight, it))


if __name__ == '__main__':
    do_knap()
