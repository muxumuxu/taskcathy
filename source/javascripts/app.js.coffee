#= require vendor/smooth-scroll
#= require_tree .

focusButtons = document.querySelectorAll('[data-focus]')
for button in focusButtons
  button.addEventListener 'click', (e)->
    input = document.getElementById(button.dataset.focus)
    setTimeout (=> input.focus()), 200
  , false

smoothScroll.init()

fixedHeaderPosition = 400
fixedHeaderClass = 'shown'
fixedHeader = document.querySelector '.header--fixed'
isHeaderFixed = ->
  if window.scrollY > fixedHeaderPosition
    fixedHeader.classList.add fixedHeaderClass
  else
    fixedHeader.classList.remove fixedHeaderClass

sections = document.querySelectorAll('body > .section')
sectionsLink = document.querySelectorAll('.header--fixed .header-menu-list [data-anchor]')
sectionsOffset = {}
for section in sections
  sectionsOffset[section.id] = section.offsetTop - section.scrollTop + section.clientTop + section.clientHeight

getCurrentSection = ->
  screenPosition = window.scrollY + (screen.height / 3)
  for name, offset of sectionsOffset
    return name if screenPosition < offset

setCurrentSection = ->
  currentSection = getCurrentSection()
  for link in sectionsLink
    if link.dataset.anchor == currentSection
      link.classList.add 'current'
    else
      link.classList.remove 'current'

window.addEventListener 'scroll', (e)->
  isHeaderFixed()
  setCurrentSection()
