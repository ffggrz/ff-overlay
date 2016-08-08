#!/usr/bin/python

from distutils.core import setup

##data_files=[('share/pdfshuffler', ['data/pdfshuffler.ui']),
##            ('share/applications', ['data/pdfshuffler.desktop']),
##            ('share/man/man1', ['doc/pdfshuffler.1']),
##            ('share/pixmaps', ['data/pdfshuffler.png']),
##            ('share/pdfshuffler/icons/hicolor/scalable',
##                ['data/pdfshuffler.svg']) ]


setup(name='tunneldigger',
      version='0.3.0-git',
      author='wlan slovenija',
      author_email='development at wlan-si.net',
      description='A simple VPN tunneling solution based on L2TPv3 tunnels',
      url = 'https://github.com/wlanslovenija/tunneldigger',
      license='AGPL',
      scripts=['bin/tunneldigger-broker'],
      packages=['broker']
##      packages=['broker'],
##      data_files=data_files
     )
