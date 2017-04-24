require "nokogiri"
require 'open-uri'

class SvgImage < ApplicationRecord
  has_many :ships

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Element
  # skip font elements
  # skip Graphics referencing elements
  # skip html elements lol
  #
  ALLOWED_TAGS = %w[
    animate animateColor animateMotion animateTransform discard mpath set
    circle ellipse line polygon polyline rect
    a defs g marker mask missing-glyph pattern svg switch symbol unknown
    desc metadata title
    feBlend feColorMatrix feComponentTransfer feComposite feConvolveMatrix
    feDiffuseLighting feDisplacementMap feDropShadow feFloodfeFuncA feFuncB
    feFuncG feFuncRfeGaussianBlur feImage feMerge feMergeNode feMorphology
    feOffset feSpecularLighting feTile feTurbulence
    linearGradient meshgradient radialGradient stop
    circle ellipse image line mesh path polygon polyline rect text use
    feDistantLight fePointLight feSpotLight
    clipPath defs hatch linearGradient marker mask meshgradient metadata
    pattern radialGradient script style symbol title hatch linearGradient
    meshgradient pattern radialGradient solidcolor defs g svg symbol use
    altGlyph altGlyphDef altGlyphItem glyph glyphRef textPath text tref tspan
    style circle ellipse line mesh path polygon polyline rect
  ].map(&:downcase).freeze

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute
  ALLOWED_ATTRIBUTES = %w[
    accent-height accumulate additive alignment-baseline allowReorder
    alphabetic amplitude arabic-form ascent attributeName attributeType
    autoReverse azimuth baseFrequency baseline-shift baseProfile bbox begin
    bias by calcMode cap-height class clip clipPathUnits clip-path clip-rule
    color color-interpolation color-interpolation-filters color-profile
    color-rendering contentScriptType contentStyleType cursor cx cy d
    decelerate descent diffuseConstant direction display divisor
    dominant-baseline dur dx dy edgeMode elevation enable-background end
    exponent externalResourcesRequired fill fill-opacity fill-rule filter
    filterRes filterUnits flood-color flood-opacity font-family font-size
    font-size-adjust font-stretch font-style font-variant font-weight format
    from fx fy g1 g2 glyph-name glyph-orientation-horizontal
    glyph-orientation-vertical glyphRef gradientTransform gradientUnits hanging
    height href horiz-adv-x horiz-origin-x id ideographic image-rendering in
    in2 intercept k k1 k2 k3 k4 kernelMatrix kernelUnitLength kerning keyPoints
    keySplines keyTimes lang lengthAdjust letter-spacing lighting-color
    limitingConeAngle local marker-end marker-mid marker-start markerHeight
    markerUnits markerWidth mask maskContentUnits maskUnits mathematical max
    media method min mode name numOctaves offset onabort onactivate onbegin
    onclick onend onerror onfocusin onfocusout onload onmousedown onmousemove
    onmouseout onmouseover onmouseup onrepeat onresize onscroll onunload onzoom
    opacity operator order orient orientation origin overflow overline-position
    overline-thickness panose-1 paint-order pathLength patternContentUnits
    patternTransform patternUnits pointer-events points pointsAtX pointsAtY
    pointsAtZ preserveAlpha preserveAspectRatio primitiveUnits r radius refX
    refY rendering-intent repeatCount repeatDur requiredExtensions
    requiredFeatures restart result rotate rx ry scale seed shape-rendering
    slope spacing specularConstant specularExponent speed spreadMethod
    startOffset stdDeviation stemh stemv stitchTiles stop-color stop-opacity
    strikethrough-position strikethrough-thickness string stroke
    stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin
    stroke-miterlimit stroke-opacity stroke-width style surfaceScale
    systemLanguage tabindex tableValues target targetX targetY text-anchor
    text-decoration text-rendering textLength to transform type u1 u2
    underline-position underline-thickness unicode unicode-bidi unicode-range
    units-per-em v-alphabetic v-hanging v-ideographic v-mathematical values
    version vert-adv-y vert-origin-x vert-origin-y viewBox viewTarget
    visibility width widths word-spacing writing-mode x x-height x1 x2
    xChannelSelector xlink:actuate xlink:arcrole xlink:role
    xlink:show xlink:title xlink:type xml:base xml:lang xml:space y y1 y2
    yChannelSelector z zoomAndPan xmlns xmlns:xlink
  ].freeze

  def self.sanitize(svg_data)
    svg_data
    #ActionController::Base.helpers.sanitize(svg_data,
    #                                        tags: ALLOWED_TAGS,
    #                                        attributes: ALLOWED_ATTRIBUTES)
  end

  def colorized_image_url(color)
    "/svg_images/#{id}.svg?color=#{URI::encode(color)}"
  end

  def random_colorized_image_url
    colorized_image_url('aqua'.paint.palette.tetrad(size: 15, as: :hex).sample)
  end

  def sanitized_data
    self.class.sanitize(data)
  end

  def colorize(color)
    svg_data = sanitized_data
    doc = Nokogiri::XML(svg_data)
    doc.css('path').each do |path|
      path.set_attribute('fill', color)
    end
    formatted_no_decl = Nokogiri::XML::Node::SaveOptions::FORMAT +
                        Nokogiri::XML::Node::SaveOptions::NO_DECLARATION

    self.class.sanitize(doc.to_xml(save_with: formatted_no_decl))
  end
end
