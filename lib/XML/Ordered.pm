package XML::Ordered;
# ABSTRACT: Convert document-oriented XML to data structures, preserving element order
our $VERSION = '0.01'; # VERSION

use XML::LibXML::Reader;
use XML::Ordered::Reader;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(readXML);

sub readXML {
    my ($input, %options) = @_;
    
    # options include 'recover' etc.
    my $reader = XML::LibXML::Reader->new( string => $input, %options );
    # from string, filename, GLOB, IO::Handle...

    my $r = XML::Ordered::Reader->new( %options );
    return $r->read($reader);

}


1;

__END__

=pod

=head1 NAME

XML::Ordered - Convert document-oriented XML to data structures, preserving element order

=head1 VERSION

version 0.01

=head1 SYNOPSIS

...

=head1 DESCRIPTION

This module implements a mapping of XML to Perl data structures for
document-oriented XML. The mapping preserves element order but XML comments,
processing-instructions, unparsed entities etc. are ignored.

    <root>
      <foo>text</foo>
      <bar key="value">
        text
        <doz/>
      </bar>
    </root>

is transformed to

    [
      "root", { }, [
        [ "foo", { }, "text" ],
        [ "bar", { key => "value" }, [
          "text", 
          [ "doz", { } ]
        ] 
      ]
    ]

=head1 SEE ALSO

L<XML::Simple>, L<XML::Fast>, L<XML::GenericJSON>, L<XML::Structured>

=encoding utf8

=head1 AUTHOR

Jakob Voß

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Jakob Voß.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
