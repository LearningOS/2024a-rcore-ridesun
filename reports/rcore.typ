#let conf(
	title,
	doc
)={
set page(
	paper:"a4",
	margin:(x:2.5cm,y:2.5cm)
)
set text(font: ("JetBrains Mono","PingFang SC"),weight: "regular", size: 10pt)
set par(first-line-indent: 2em)

let fakepar = style(styles => {
  let b = par[#box()]
  let t = measure(b + b, styles);

  b
  v(-t.height)
})

let divider=style(styles=>{
	v(-14pt)
	line(length: 100%, stroke: (thickness: 0.5pt))
})

show raw.where(block: true):block.with(
	fill: luma(250),
	inset: 8pt,
	radius: 4pt
)

show heading: it => {
  it
	divider
  fakepar
}

align(center,text(size: 20pt)[#title])

doc
}
